{ config, pkgs, ... }: {
  imports = [
    ./hyprland.nix # Use Hyprland, as the Wayland compositor.
    ./waybar.nix # Use Waybar as the statusbar for Wayland.
  ];

  home.packages = with pkgs; [
    wofi # Application runner
    dolphin # File browser
    swaybg # Used for setting the background image
    grimblast # Used for screenshots in Hyprland
  ];
}
