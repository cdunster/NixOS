{ pkgs, lib, config, ... }: {
  options.hostOptions.autorandr = with lib; {
    enable = mkEnableOption "Enable autorandr to automatically manage displays";

    displays = {
      # The details of the laptop display as determined by `autorandr --fingerprint`, set fingerprint to `null` if not a laptop
      laptop = {
        id = mkOption {
          type = types.nonEmptyStr;
          default = "eDP-1";
          description = "The ID of the laptop display, usually eDP-1";
        };

        fingerprint = mkOption {
          type = types.nullOr types.nonEmptyStr;
          description = "The fingerprint of the laptop display, set to `null` if no laptop screen";
        };
      };

      homeMonitor = {
        id = mkOption {
          type = types.nonEmptyStr;
          description = "The ID of the monitor at home as determined by `autorandr --fingerprint`";
        };
      };
    };
  };

  config =
    let
      cfg = config.hostOptions.autorandr;
    in
    lib.mkIf cfg.enable {
      services.autorandr = {
        enable = true;
        profiles =
          # Profiles that include the laptop display
          lib.mkIf (cfg.displays.laptop.fingerprint != null) {
            undocked = {
              fingerprint = {
                ${cfg.displays.laptop.id} = "${cfg.displays.laptop.fingerprint}";
              };
              config = {
                ${cfg.displays.laptop.id} = {
                  enable = true;
                  mode = "2880x1920";
                  rate = "120.00";
                  dpi = 192;
                };
              };
            };
            docked-home = {
              fingerprint = {
                ${cfg.displays.laptop.id} = "${cfg.displays.laptop.fingerprint}";
                ${cfg.displays.homeMonitor.id} = "00ffffffffffff004c2df2720000000008200104b55123783bbc55b04d3db7250f505421080081c0810081809500a9c0b300010101016d8870a0d0a0b25030203a0029623100001a000000fd003078c3c346010a202020202020000000fc004f647973736579204738355342000000ff004831414b3530303030300a202002c8020322f144903f04032309070783010000e305c301e6060501604a00e5018b849039565e00a0a0a029503020350029623100001a6fc200a0a0a055503020350029623100001a0474801871382d40582c450029623100001e000000000000000000000000000000000000000000000000000000000000000000000000000000c8701279030003013cf21001886f0d9f002f801f009f05b100020009004e230108ff099f002f801f009f057e0002000400fda600087f079f002f801f0037045e0002000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a90";
              };
              config = {
                ${cfg.displays.laptop.id}.enable = false;
                ${cfg.displays.homeMonitor.id} = {
                  enable = true;
                  primary = true;
                  mode = "3440x1440";
                  rate = "119.96";
                };
              };
            };
          };
      };

      home-manager.users.${config.hostOptions.user}.xdg.configFile."autostart/autorandr.desktop".text = (pkgs.makeDesktopItem {
        name = "autorandr";
        desktopName = "Autorandr Change Profile";
        exec = "${pkgs.autorandr}/bin/autorandr --change";
        noDisplay = true;
      }).text;
    };
}
