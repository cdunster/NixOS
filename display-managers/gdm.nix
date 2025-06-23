{ lib, config, ... }:
let
  cfg = config.hostOptions.displayManagers;
in
lib.mkIf (cfg.displayManager == "gdm") {
  # Use the GNOME Display Manager (GDM)
  services.displayManager.gdm = {
    enable = true;
    wayland = cfg.enableWayland;
  };

  # Required workaround for autoLogin.
  systemd.services = lib.mkIf cfg.enableAutoLogin {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
}
