{ pkgs, lib, config, ... }:
let
  cfg = config.hostOptions.desktopEnvironment.gnome;
in
{
  config = lib.mkIf cfg.enable {
    services.xserver = {
      # Use the GNOME Display Manager (GDM)
      displayManager.gdm = {
        enable = true;

        # Disable the use of Wayland with GNOME (use X11 instead)
        wayland = false;
      };

      # Use the GNOME Desktop Environment
      desktopManager.gnome.enable = true;
    };

    # Exclude these packages from the GNOME install
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
  };
}

