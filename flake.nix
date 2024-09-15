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

    # The catppuccin theme for everything
    catppuccin.url = "github:catppuccin/nix";

    # Enable Secure Boot on NixOS.
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neorg-overlay = {
      url = "github:nvim-neorg/nixpkgs-neorg-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { ... }@inputs:
    let
      # Get all of the hosts from the ./hosts directory, returning them as a set i.e. `{ hostOne = { ... }; hostTwo = { ... }; }`.
      hostsAsSet = inputs.nixpkgs.lib.filesystem.packagesFromDirectoryRecursive { inherit (inputs.nixpkgs.lib) callPackage; directory = ./hosts; };

      # To be used with `builtins.mapAttrs`, takes the host name from the set attribute name, discards the content and returns a `nixosSystem` with the same name.
      # e.g. `{ hostOne { foo = 42; }; }` becomes `{ hostOne = nixosSystem { ... }; }`.
      createSystem = hostName: _: inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = [
                (_final: prev: { cdunster = import inputs.cdunster-nixpkgs { system = prev.system; config = prev.config; }; })
                inputs.neorg-overlay.overlays.default
              ];
            };
          }
          {
            networking.hostName = "${hostName}";
          }
          ./hosts/${hostName}
          ./configuration.nix
          ./nixos-gnome.nix
          inputs.catppuccin.nixosModules.catppuccin
          inputs.home-manager.nixosModules.home-manager
          inputs.lanzaboote.nixosModules.lanzaboote
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.callum = {
              imports = [
                ./nixos-home.nix
                inputs.catppuccin.homeManagerModules.catppuccin
              ];
            };
            home-manager.backupFileExtension = "bak";
          }
        ];
      };
    in
    {
      nixosConfigurations = builtins.mapAttrs createSystem hostsAsSet;

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
