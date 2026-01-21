{ pkgs, lib, config, ... }: {
  options.hostOptions.rofi = with lib; {
    enable = mkEnableOption "Enable ROFI, the customisable menu and runner";
  };

  config =
    let
      cfg = config.hostOptions.rofi;
      user = config.hostOptions.user;
    in
    lib.mkIf cfg.enable {
      home-manager.users.${user} = {
        programs.rofi = {
          enable = true;
          plugins = with pkgs; [ rofi-calc ];
          modes = [ "drun" "calc" ];
          extraConfig = {
            show-icons = true;
          };
        };
      };
    };
}
