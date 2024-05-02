{ config, pkgs, ... }: {
  imports = [
    ./hyprland.nix # Use Hyprland, as the Wayland compositor.
    ./waybar.nix # Use Waybar as the statusbar for Wayland.
  ];

  home.packages = with pkgs; [
    wofi
    dolphin
    swaybg
    grimblast
  ];
}
