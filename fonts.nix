{ inputs, pkgs, config, ... }:
let
  user = config.hostOptions.user;
in
{
  # My personal fork of nixpkgs (used for the `ttf-wps-fonts` package) accessible via `cdunster.<package>`
  nixpkgs.overlays = [
    (_final: prev: { cdunster = import inputs.cdunster-nixpkgs { system = prev.system; config = prev.config; }; })
  ];


  home-manager.users.${user} = {
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      cdunster.ttf-wps-fonts
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "JetBrainsMono Nerd Font 10" ];
        monospace = [ "JetBrainsMono Nerd Font Mono 11" ];
      };
    };
  };
}
