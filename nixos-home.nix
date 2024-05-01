# Manage user accounts with home-manager for NixOS systems.
{ config, pkgs, ... }: {
  imports = [
    ./home.nix # Import the standard settings for all systems.
    ./nixos-gnome.nix # Use Gnome with NixOS specific settings and packages.
  ];

  home.packages = with pkgs; [
  ];
}
