{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { self, nixpkgs, home-manager, nixgl, ... }@attrs: {
    nixosConfigurations.MiNixOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.callum = import ./home.nix;
        }
      ];
    };

    homeConfigurations.callum = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      extraSpecialArgs = attrs;

      username = "Callum";
      homeDirectory = "/home/callum";

      configuration = { config, nixpkgs, ... }: {
        targets.genericLinux.enable = true;
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = [ nixgl.overlay ];

        home.sessionVariables = {
          SHELL = "$HOME/.nix-profile/bin/fish";
          EDITOR = "$HOME/.nix-profile/bin/nvim";
        };

        imports = [
          ./home.nix
        ];
      };
      stateVersion = "21.11";
    };
  };
}
