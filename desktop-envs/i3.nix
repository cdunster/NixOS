{ lib, config, ... }: {
  options.hostOptions.desktopEnvironments.i3 = with lib; {
    enable = mkEnableOption "Enable the i3 window manager with no desktop environment";
  };

  config =
    let
      cfg = config.hostOptions.desktopEnvironments.i3;
      user = config.hostOptions.user;
    in
    lib.mkIf cfg.enable {
      services.xserver = {
        # Enable the X11 display server
        enable = true;

        # Use the i3 window manager
        windowManager.i3.enable = true;

        # Configure keyboard layout
        xkb = {
          layout = "us";
          variant = "euro";
          options = "caps:none";
        };
      };

      # home-manager.users.${user} = {
      #   xsession.windowManager.i3.enable = true;
      # };
    };
}

