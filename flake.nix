{
  description = "NixOS and home-manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Manage user settings and dotfiles within Nix
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Predefined config for specific hardware like Framework laptops
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Enable Secure Boot on NixOS.
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Apply base16 themes, fonts, and other styling everywhere
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Plugin registry for the DankMaterialShell
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ... }@inputs:
    let
      # Get all of the hosts from the hosts directory, returning them as a set.
      allHostsAsSet = builtins.readDir ./hosts;

      # Takes each attribute from the passed set, discards the value and returns a `nixosSystem` with the same name.
      # e.g. `{ hostOne = { foo = 42; }; }` becomes `{ hostOne = nixosSystem { ... }; }`.
      mkNixosSystem = hostName: _: inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          { networking.hostName = "${hostName}"; }
          ./hosts/${hostName}
          ./nixos
          ./users
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              extraSpecialArgs = { inherit inputs; };
              sharedModules = [ ./home-manager-shared ];
            };
          }
        ];
      };
    in
    {
      nixosConfigurations = builtins.mapAttrs mkNixosSystem allHostsAsSet;
    };
}
