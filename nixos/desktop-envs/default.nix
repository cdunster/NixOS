{ ... }: {
  imports = [
    # Utilities and tooling for multiple DM/DE/WM combinations
    ./utils/gui-scale-applet.nix # Tailscale management applet for the COSMIC panel

    ./gnome.nix # The GNOME Desktop Environment
    ./cosmic.nix # The COSMIC Desktop Environment
  ];

  # Enable managing dconf with NixOS and home-manager
  programs.dconf.enable = true;
}
