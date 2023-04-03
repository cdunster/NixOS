{
  description = "NixOS and home-manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "flake-utils";
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.nixgl.overlay
          (import ./nixgl-wrapper.nix)
          (import ./pkgs-override.nix)
        ];
      };
    in
    {
      nixosConfigurations.MiNixOS = inputs.nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = inputs;
        modules = [
          ./configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.callum = import ./home.nix;
            home-manager.extraSpecialArgs = inputs;
          }
        ];
      };

      homeConfigurations.callum = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = inputs;
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
