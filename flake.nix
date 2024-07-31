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
    catppuccin.url = "github:catppuccin/nix"; # The catppuccin theme for everything
    ags.url = "github:Aylur/ags"; # A customisable shell for Wayland
  };

  outputs = { ... }@inputs: {
    nixosConfigurations.MiNixOS = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        {
          nixpkgs = {
            config.allowUnfree = true;
            overlays = [
              (_final: prev: { cdunster = import inputs.cdunster-nixpkgs { system = prev.system; config = prev.config; }; })
            ];
          };
        }
        ./hardware-configuration.nix
        ./configuration.nix
        ./nixos-gnome.nix
        ./nixos-hyprland.nix
        inputs.catppuccin.nixosModules.catppuccin
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.callum = {
            imports = [
              ./nixos-home.nix
              inputs.catppuccin.homeManagerModules.catppuccin
            ];
          };
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.backupFileExtension = "bak";
        }
      ];
    };

    homeConfigurations.callum = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
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
        inputs.catppuccin.homeManagerModules.catppuccin
      ];
    };
  };
}
