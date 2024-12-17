{ ... }: {
  imports = [
    # Utilities and tooling for multiple DM/DE/WM combinations
    ./utils/autorandr.nix # Automatically configure displays for X11
    ./utils/polybar.nix # A panel/top-bar that works across multiple X11 DEs / WMs
    ./utils/rofi.nix # A highly customisable menu and application runner

    ./gnome.nix # The GNOME Desktop Environment

    ./i3.nix # The i3 tiling window manager with no desktop environment
  ];
}
