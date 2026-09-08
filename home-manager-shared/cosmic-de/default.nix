{ lib, osConfig, ... }: {
  imports = [
    # An applet to control Tailscale networks and settings
    ./gui-scale-applet.nix
  ];

  config = {
    # If COSMIC DE is enabled, let it manage GTK and Qt theming instead of Stylix
    stylix.targets = lib.mkIf osConfig.services.desktopManager.cosmic.enable {
      gtk.enable = false;
      qt.enable = false;
    };
  };
}
