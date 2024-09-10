{ pkgs, ... }:
{
  imports = [
    ./autorandr.nix # Use autorandr to automatically configure monitors.
  ];

  # Enable managing dconf with NixOS and home-manager modules.
  programs.dconf.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Configure keyboard layout.
    xkb = {
      layout = "us";
      variant = "euro";
      options = "caps:none";
    };

    # Use the GNOME Display Manager (GDM).
    displayManager.gdm = {
      enable = true;

      # Disable the use of Wayland with GNOME (use X11 instead).
      wayland = false;
    };

    # Use the GNOME Desktop Environment.
    desktopManager.gnome.enable = true;
  };

  # Exclude these packages from the Gnome install.
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-connections
    gnome-console # GNOME terminal emulator
    gedit # text editor
    epiphany # web browser
    gnome-terminal
    gnome-music
    gnome-characters
    gnome-contacts
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    gnome-weather
  ]);
}

