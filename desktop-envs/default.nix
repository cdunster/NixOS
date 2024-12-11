{ ... }: {
  imports = [
    # Utilities and tooling for multiple DM/DE/WM combinations
    ./utils/autorandr.nix # Automatically configure displays for X11
    ./utils/polybar.nix # A panel/top-bar that works across multiple X11 DEs / WMs

    ./gnome.nix # The GNOME Desktop Environment
  ];
}
