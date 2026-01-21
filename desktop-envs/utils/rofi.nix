{ pkgs, lib, config, ... }: {
  options.hostOptions.rofi = with lib; {
    enable = mkEnableOption "Enable ROFI, the customisable menu and runner";
  };

  config =
    let
      cfg = config.hostOptions.rofi;
      user = config.hostOptions.user;

      rofi-sound = pkgs.writeShellApplication {
        name = "rofi-sound";
        text = ''
          echo -en "\x00prompt\x1fSound Output\n"

          if [ "$@" ]; then
              coproc pactl set-default-sink "$ROFI_INFO"
          else
              pactl list sinks | awk '
                  /^Sink #[0-9]+/ {
                      name = ""
                      desc = ""
                      in_ports = 0
                      port_count = 0
                  }
                  /^\tName: / { name = substr($0, index($0, ":") + 2) }
                  /^\tDescription: / { desc = substr($0, index($0, ":") + 2) }
                  /^\tActive Port: / {
                      in_ports = false
                      active_port = substr($0, index($0, ":") + 2)

                      icon = "speaker"
                      for (i = 0; i <= port_count; i++) {
                          if (ports_name[i] ~ active_port) {
                              icon = ports_icon[i]
                              break
                          }
                      }

                      if (name != "" && desc != "") {
                          print desc "\x0icon\x1f" icon "\x1finfo\x1f"name
                      }
                  }
                  in_ports {
                      ports_name[port_count] = substr($1, 1, index($1, ":") - 1)

                      type = tolower($2)
                      if (type ~ /headphone/) ports_icon[port_count] = "headphones"
                      else if (type ~ /headset/) ports_icon[port_count] = "headset"
                      else if (type ~ /hdmi/) ports_icon[port_count] = "computer"
                      else ports_icon[port_count] = "speaker"

                      port_count++
                  }
                  /^\tPorts:/ { in_ports = 1 }
              '
          fi
        '';
      };
    in
    lib.mkIf cfg.enable {
      home-manager.users.${user} = {
        home.packages = with pkgs; [
          # Bluetooth
          bzmenu
          bluez

          # Network
          rofi-network-manager
        ];
        programs.rofi = {
          enable = true;
          plugins = with pkgs; [ rofi-calc ];
          modes = [
            "drun"
            "calc"
            {
              name = "power-menu";
              path = lib.getExe pkgs.rofi-power-menu;
            }
            {
              name = "sound";
              path = lib.getExe rofi-sound;
            }
          ];
          extraConfig = {
            show-icons = true;
          };
        };
      };
    };
}
