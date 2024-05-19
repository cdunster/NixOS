# Manage user accounts with home-manager for NixOS systems.
{ config, pkgs, ... }: {
  imports = [
    ./home.nix # Import the standard settings for all systems.
    ./nixos-gnome.nix # Use Gnome with NixOS specific settings and packages.
    ./wayland.nix # Add support for Wayland.
  ];

  # For managing networks in the system tray.
  services.network-manager-applet.enable = true;

  home.packages = with pkgs; [
  ];
}
