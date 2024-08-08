{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Configure keyboard layout.
    xkb = {
      layout = "us";
      variant = "euro";
      options = "caps:none";
    };

    # Use Gnome.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Exclude these packages from the Gnome install.
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-connections
    gnome-console # GNOME terminal emulator
    gedit # text editor
    geary # email reader
    epiphany # web browser
    gnome-terminal
  ]) ++ (with pkgs.gnome; [
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

