{ config, pkgs, ... }: {
  imports = [
    ./hyprland.nix # Use Hyprland, as the Wayland compositor.
  ];

  home.packages = with pkgs; [
    wofi
    dolphin
    swaybg
    grimblast
  ];
}
