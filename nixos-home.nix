# Manage user accounts with home-manager for NixOS systems.
{ config, pkgs, ... }: {
  imports = [
    ./home.nix # Import the standard settings for all systems.
  ];

  home.packages = with pkgs; [
    # Gnome
    # gnomeExtensions.material-shell # Nice WM for non-Pop!_OS systems:
    gnomeExtensions.pop-shell # The GNOME Shell used in Pop!_OS.
    gnomeExtensions.dash-to-dock # Configure the GNOME dash/dock.
    gnome.gnome-session # Utility to control the GNOME shell session.
    pop-icon-theme # The icons used by Pop!_OS.
  ];
}
