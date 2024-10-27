# This is actually the NixOS module used to enable and setup home-manager
{ inputs, config, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${config.hostOptions.user} = ./home.nix;
        backupFileExtension = "bak";
      };
    }
  ];
}
