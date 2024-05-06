# The general Gnome utilities, plugins, and settings for both NixOS and non-NixOS systems.
{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnome-extension-manager # Find, install, and manager gnome extensions
    gnome-tweaks # Extra settings for tweaking gnome
  ];
}