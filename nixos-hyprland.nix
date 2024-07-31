{ ... }:
{
  # Enable the Hyprland Wayland compositor.
  programs.hyprland.enable = true;

  # Hint to electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}

