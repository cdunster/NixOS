# This is actually the NixOS module used to enable and setup home-manager
{ inputs, config, options, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${config.hostOptions.user} = {
        imports = [
          {
            # Copy the custom hostOptions definitions from NixOS to home-manager
            options.hostOptions = options.hostOptions;

            # Copy the custom hostOptions values from NixOS to home-manager
            config.hostOptions = config.hostOptions;
          }
          ./home.nix # Import the standard settings for all systems.
          ./gnome.nix # Add packages required for GNOME DE
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };
      home-manager.backupFileExtension = "bak";
    }
  ];
}
