# Manage user accounts with home-manager
{ ... }: {
  imports = [
    ./home.nix # Import the standard settings for all systems.
    ./gnome.nix # Add packages required for GNOME DE
  ];
}
