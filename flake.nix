{
  description = "NixOS and home-manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # The catppuccin theme for everything
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Enable Secure Boot on NixOS.
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neorg-overlay = {
      url = "github:nvim-neorg/nixpkgs-neorg-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Path to the zip file downloaded from https://www.lexaloffle.com/pico-8.php
    pico-8-src = {
      url = "path:/home/callum/Downloads/pico-8_0.2.6b_amd64.zip";
      flake = false;
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
          ./configuration.nix
        ];
      };
    in
    {
      nixosConfigurations = builtins.mapAttrs mkNixosSystem allHostsAsSet;
    };
}
