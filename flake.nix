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
      # Get all of the hosts from the hosts directory, returning them as a set.
      allHostsAsSet = builtins.readDir ./hosts;

      # Takes each attribute from the passed set, discards the value and returns a `nixosSystem` with the same name.
      # e.g. `{ hostOne = { foo = 42; }; }` becomes `{ hostOne = nixosSystem { ... }; }`.
      mkNixosSystem = hostName: _: inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          { networking.hostName = "${hostName}"; }
          ./host-options.nix
          ./hosts/${hostName}
          ./configuration.nix
        ];
      };
    in
    {
      nixosConfigurations = builtins.mapAttrs mkNixosSystem allHostsAsSet;
    };
}
