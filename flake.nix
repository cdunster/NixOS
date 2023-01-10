{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixgl, ... }@attrs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nixgl.overlay
          (import ./pkgs-override.nix)
        ];
      };
    in
    {
      nixosConfigurations.MiNixOS = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = attrs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.callum = import ./home.nix;
            home-manager.extraSpecialArgs = attrs;
          }
        ];
      };

      homeConfigurations.callum = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = attrs;
        modules = [
          {
            home = {
              username = "Callum";
              homeDirectory = "/home/callum";
            };
          }
          {
            targets.genericLinux.enable = true;
          }
          ./home.nix
        ];
      };
    };
}
