{
  description = "NixOS and home-manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    cdunster-nixpkgs.url = "github:cdunster/nixpkgs?ref=wps-fonts";

    home-manager = {
      url = "home-manager";
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
      # Get all of the hosts from the hosts directory, returning them as a set i.e. `{ hostOne = { ... }; hostTwo = { ... }; }`.
      allHostsAsSet = inputs.nixpkgs.lib.filesystem.packagesFromDirectoryRecursive { inherit (inputs.nixpkgs.lib) callPackage; directory = ./hosts; };

      # Takes each attribute from the passed set, discards the value and returns a `nixosSystem` with the same name.
      # e.g. `{ hostOne = { foo = 42; }; }` becomes `{ hostOne = nixosSystem { ... }; }`.
      mkNixosSystem = hostName: _: inputs.nixpkgs.lib.nixosSystem {
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
          ./display-servers
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
      nixosConfigurations = builtins.mapAttrs mkNixosSystem allHostsAsSet;
    };
}
