{ pkgs, ... }:
{
  # Enable the Hyprland Wayland compositor.
  programs.hyprland.enable = true;

  # Hint to electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Daemon for login management.
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };
}

