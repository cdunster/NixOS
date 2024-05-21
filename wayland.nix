{ config, pkgs, ... }: {
  imports = [
    ./hyprland.nix # Use Hyprland, as the Wayland compositor.
    ./hypridle.nix # Use Hypridle, as the idle daemon for Hyprland.
    ./hyprlock.nix # Use Hyprlock as the lockscreen for Hyprland.
    ./hyprpaper.nix # Use Hyprpaper as the background setter for Hyprland.
    ./kanshi.nix # Use Kanshi for dynamic control of monitors on Wayland.
    ./ags.nix # Customisable shell for Wayland.
  ];

  home.packages = with pkgs; [
    wl-clipboard # Clipboard manager for Wayland
    playerctl # Media controller
    dolphin # File browser
    grimblast # Used for screenshots in Hyprland
    kanshi # Used to reload/switch monitor profiles
  ];
}
