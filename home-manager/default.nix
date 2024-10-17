# Manage user accounts with home-manager
{ ... }: {
  imports = [
    ./home.nix # Import the standard settings for all systems.
    ./home-nixos-gnome.nix # Use Gnome with NixOS specific settings and packages.
  ];
}
