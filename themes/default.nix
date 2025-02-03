{ config, ... }:
let
  user = config.hostOptions.user;
in
{
  imports = [
    ./catppuccin.nix
  ];

  home-manager.users.${user}.gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };
}
