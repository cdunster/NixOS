{ pkgs, config, ... }:
let
  user = config.hostOptions.user;
in
{
  home-manager.users.${user} = {
    home.packages = with pkgs;
      let
        rofi-wifi-menu = stdenv.mkDerivation {
          pname = "rofi-wifi-menu";
          version = "unstable-2023-11-23";

          src = fetchFromGitHub {
            owner = "ericmurphyxyz";
            repo = "rofi-wifi-menu";
            rev = "d6debde6e302f68d8235ced690d12719124ff18e";
            sha256 = "H+vBRdGcSDMKGLHhPB7imV148O8GRTMj1tZ+PLQUVG4=";
          };

          nativeBuildInputs = [ makeWrapper ];

          installPhase = ''
            runHook preInstall

            install -D ./rofi-wifi-menu.sh $out/bin/rofi-wifi-menu

            wrapProgram $out/bin/rofi-wifi-menu --prefix PATH ":" ${lib.makeBinPath [ libnotify networkmanager ] }

            runHook postInstall
          '';
        };
      in
      [
        rofi-bluetooth
        rofi-power-menu
        rofi-wifi-menu
      ];
    programs.rofi = {
      enable = true;
      plugins = with pkgs; [ rofi-calc ];
      extraConfig = {
        modes = [ "drun" "calc" "window" ];
        show-icons = true;
        window-format = "{c:25} {t}";
      };
    };
  };
}
