{ ... }: {
  imports = [
    # Utilities and tooling for multiple DM/DE/WM combinations
    ./utils/autorandr.nix # Automatically configure displays for X11

    ./gnome.nix # The GNOME Desktop Environment
  ];
}
