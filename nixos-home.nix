# Manage user accounts with home-manager for NixOS systems.
{ ... }: {
  imports = [
    ./home.nix # Import the standard settings for all systems.
    ./home-nixos-gnome.nix # Use Gnome with NixOS specific settings and packages.
    ./wayland.nix # Add support for Wayland.
  ];

  # For managing bluetooth devices in the system tray.
  services.blueman-applet.enable = true;
}
