# The general Gnome utilities, plugins, and settings for both NixOS and non-NixOS systems.
{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnome-extension-manager # Find, install, and manager gnome extensions
    dracula-theme # Dracula theme for the gnome shell
    gnome-tweaks # Extra settings for tweaking gnome
  ];
}
