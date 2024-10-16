{ ... }: {
  imports = [
    # X.Org tooling for all DM/DE/WM combinations
    ./autorandr.nix # Use autorandr to automatically configure monitors

    # Display Managers, Desktop Environments, and Window Managers
    ./gnome.nix # The GNOME DM/DE using X11
  ];

  # Enable managing dconf with NixOS and home-manager modules
  programs.dconf.enable = true;

  # Enable the X11 display server
  services.xserver = {
    enable = true;

    # Configure keyboard layout
    xkb = {
      layout = "us";
      variant = "euro";
      options = "caps:none";
    };
  };
}

