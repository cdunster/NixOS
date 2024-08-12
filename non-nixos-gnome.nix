# Gnome packages and options for non-NixOS systems (Pop!_OS).
{ config, pkgs, ... }: {
  imports = [
    ./gnome.nix # The general Gnome packages for all systems.
  ];

  home.packages = with pkgs; [
    # Gnome
    evince # Gnome based document viewer
    gnome42Extensions."emoji-selector@maestroschan.fr" # Select emojis with nice gnome UI
    gnome42Extensions."sound-output-device-chooser@kgshank.net" # Audio device selector in the gnome quick settings
    gnome42Extensions."auto-move-windows@gnome-shell-extensions.gcampax.github.com" # Move an application to a set window when opened
    gnome42Extensions."user-theme@gnome-shell-extensions.gcampax.github.com" # Enable custom gnome shell themes
    gnome42Extensions."bluetooth-quick-connect@bjarosze.gmail.com" # Bluetooth device selector in the gnome quick settings
  ];
}
