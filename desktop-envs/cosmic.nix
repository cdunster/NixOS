{ lib, config, ... }: {
  options.hostOptions.desktopEnvironments.cosmic = with lib; {
    enable = mkEnableOption "Enable the COSMIC desktop environment";
  };

  config =
    let
      cfg = config.hostOptions.desktopEnvironments.cosmic;
    in
    lib.mkIf cfg.enable {
      services.desktopManager.cosmic = {
        # Enable the COSMIC DE itself
        enable = true;

        # Enable XWayland support in COSMIC
        xwayland.enable = true;
      };

      environment.sessionVariables = {
        # Enable clipboard manager support
        COSMIC_DATA_CONTROL_ENABLED = 1;

        # Hint to electron apps to use wayland
        NIXOS_OZONE_WL = "1";
      };

      # Allow opening links in web browser from any app
      systemd.user.extraConfig = ''DefaultEnvironment="PATH=/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"'';
    };
}
