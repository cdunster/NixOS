{ pkgs, config, ... }:
let
  user = config.hostOptions.user;
in
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  home-manager.users.${user}.fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "JetBrainsMono Nerd Font 10" ];
      monospace = [ "JetBrainsMono Nerd Font Mono 11" ];
    };
  };
}
