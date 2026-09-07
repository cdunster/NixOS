{ lib, config, ... }: {
  # TODO: Remove after migration
  options.hostOptions = with lib; {
    user = mkOption {
      type = types.nonEmptyStr;
      default = toLower config.hostOptions.userName;
      description = "The used name of the system user";
    };
  };

  config =
    let
      user = "callum";
      fullName = "Callum Dunster";
      isNetworkManagerEnabled = config.networking.networkmanager.enable;
      isVirtualBoxEnabled = config.virtualisation.virtualbox.host.enable;
      isDockerEnabled = config.virtualisation.docker.enable;
    in
    {
      # Define the NixOS system user.
      users.users.${user} = {
        isNormalUser = true;
        description = fullName;
        extraGroups = [ "wheel" ]
          ++ lib.lists.optional isNetworkManagerEnabled "networkmanager"
          ++ lib.lists.optional isVirtualBoxEnabled "vboxusers"
          ++ lib.lists.optional isDockerEnabled "docker"
        ;
      };

      # Enable automatic login for this user
      services.displayManager.autoLogin = {
        enable = true;
        inherit user;
      };

      home-manager.users.${user} = ./home-manager;

      hostOptions.user = user;
    };
}
