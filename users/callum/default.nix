{ pkgs, lib, config, ... }: {
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
        shell = pkgs.fish;
      };

      # Enable automatic login for this user
      services.displayManager.autoLogin = {
        enable = true;
        inherit user;
      };

      # Load the home-manager configuration for this user
      home-manager.users.${user} = ./home-manager;
    };
}
