{ lib, config, ... }: {
  options.hostOptions.displayManagers.gdm = with lib; {
    enable = mkEnableOption "Enable the GNOME Display Manager";
    wayland = mkEnableOption "Use Wayland as the display protocol instead of X11";
  };

  config =
    let
      cfg = config.hostOptions.displayManagers.gdm;
      inherit (config.hostOptions.displayManagers) enableAutoLogin;
    in
    lib.mkIf cfg.enable {
      # Use the GNOME Display Manager (GDM)
      services.xserver.displayManager.gdm = {
        enable = true;
        inherit (cfg) wayland;
      };

      # Required workaround for autoLogin.
      systemd.services = lib.mkIf enableAutoLogin {
        "getty@tty1".enable = false;
        "autovt@tty1".enable = false;
      };
    };
}
