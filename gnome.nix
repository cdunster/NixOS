# The general Gnome utilities, plugins, and settings for both NixOS and non-NixOS systems.
{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # Gnome
    gnome-extension-manager # Find, install, and manager gnome extensions
    dracula-theme # Dracula theme for the gnome shell
    gnome.gnome-tweaks # Extra settings for tweaking gnome
  ];
}
