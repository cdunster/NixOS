# Gnome packages and settings for NixOS systems.
{ config, pkgs, ... }: {
  imports = [
    ./gnome.nix # The general Gnome packages for all systems.
  ];

  home.packages = with pkgs; [
    # gnomeExtensions.material-shell # Nice WM for non-Pop!_OS systems:
    gnomeExtensions.pop-shell # The GNOME Shell used in Pop!_OS.
  ];
}
