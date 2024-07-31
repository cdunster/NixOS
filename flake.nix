{
  description = "NixOS and home-manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    cdunster-nixpkgs.url = "github:cdunster/nixpkgs?ref=wps-fonts";
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.MiNixOS = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            (final: _prev: { cdunster = import inputs.cdunster-nixpkgs { system = final.system; config = final.config; }; })
          ];
        };
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./nixos-gnome.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.callum = import ./nixos-home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      homeConfigurations.callum = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            inputs.nixgl.overlay
            (import ./nixgl-wrapper.nix)
            (import ./pkgs-override.nix)
          ];
        };
        extraSpecialArgs = inputs;
        modules = [
          {
            home = {
              username = "callum";
              homeDirectory = "/home/callum";
            };
          }
          {
            targets.genericLinux.enable = true;
          }
          ./home.nix
          ./non-nixos-gnome.nix
        ];
      };
    };
}
