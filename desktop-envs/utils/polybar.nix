{ config, ... }:
let
  user = config.hostOptions.user;
in
{
  home-manager.users.${user} = {
    services.polybar = {
      enable = true;
      script = "polybar main &";
      settings = {
        theme = {
          bg-main = "\${colors.crust}";
          fg-disabled = "\${colors.subtext0}";
          fg-alert = "\${colors.red}";
        };
        settings = {
          screenchange-reload = true;
        };
        "bar/main" = {
          background = "\${theme.bg-main}";
          font-0 = "JetBrainsMono Nerd Font:pixelsize=12";
          font-1 = "JetBrainsMono Nerd Font:pixelsize=8";

          offset-y = "3.5%";

          module-margin = "1";

          modules-left = "workspaces tray";
          modules-center = "date";
          modules-right = "cpu memory temperature bluetooth network sound battery";
        };
        "module/workspaces" = {
          type = "internal/xworkspaces";

          enable-scroll = "false";

          label-empty = "";
          label-empty-padding = "1";
          label-occupied = "";
          label-occupied-padding = "1";
          label-urgent = "";
          label-urgent-padding = "1";
          label-active = "";
          label-active-padding = "1";
        };
        "module/date" = {
          type = "internal/date";

          date = "%a %d %b";
          time = "%H:%M:%S";
          interval = "1.000000";
          label = "%date% %time%";
        };
        "module/tray" = {
          type = "internal/tray";
        };
        "module/cpu" = {
          type = "internal/cpu";

          format = "󰍛 <label>";
          label = "%percentage:2%%";
        };
        "module/memory" = {
          type = "internal/memory";

          format = "  <label>";
        };
        "module/temperature" = {
          type = "internal/temperature";

          hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon5/temp1_input";
          base-temperature = "40";

          format = "<ramp> <label>";

          ramp-0 = "󱃃";
          ramp-1 = "󰔏";
          ramp-2 = "󱃂";

          format-warn = "<ramp> <label-warn>";
          format-warn-foreground = "\${theme.fg-alert}";
        };
        "module/bluetooth" = {
          type = "custom/script";

          exec = "${./polybar-scripts/system-bluetooth-bluetoothctl.sh}";
          tail = "true";
          click-middle = "${./polybar-scripts/system-bluetooth-bluetoothctl.sh} --toggle &";
        };
        "module/network" = {
          type = "internal/network";

          # List interfaces with: `ip link`
          interface = "wlp1s0";

          format-connected = "<ramp-signal> <label-connected>";
          label-connected = "%essid% %{T2}%upspeed:5% %downspeed:5%%{T-}";
          speed-unit = " ";

          ramp-signal-0 = "󰤯";
          ramp-signal-1 = "󰤟";
          ramp-signal-2 = "󰤢";
          ramp-signal-3 = "󰤥";
          ramp-signal-4 = "󰤨";

          format-disconnected = "󰤮";
          format-disconnected-foreground = "\${theme.fg-disabled}";

          format-packetloss = "<animation-packetloss> <label-connected>";
          animation-packetloss-0 = "󰤫";
          animation-packetloss-1 = "󰤯";
          animation-packetloss-framerate = "300";
        };
        "module/sound" = {
          type = "internal/alsa";

          format-volume = "<ramp-volume> <label-volume>";
          ramp-volume-0 = "󰕿";
          ramp-volume-1 = "󰖀";
          ramp-volume-2 = "󰕾";

          format-muted = "󰝟 <label-muted>";
          format-muted-foreground = "\${theme.fg-disabled}";
        };
        "module/battery" = {
          type = "internal/battery";

          # List batteries and adapters with: `ls -1 /sys/class/power_supply/`
          battery = "BAT1";
          adapter = "ACAD";

          format-charging = "󱐋<ramp-capacity> <label-charging>";
          label-charging = "%percentage%% %{T2}%consumption% W%{T-}";

          format-discharging = "<ramp-capacity> <label-discharging>";
          label-discharging = "%percentage%% %{T2}%consumption% W%{T-}";

          ramp-capacity-0 = "󰁺";
          ramp-capacity-1 = "󰁻";
          ramp-capacity-2 = "󰁼";
          ramp-capacity-3 = "󰁽";
          ramp-capacity-4 = "󰁾";
          ramp-capacity-5 = "󰁿";
          ramp-capacity-6 = "󰂀";
          ramp-capacity-7 = "󰂁";
          ramp-capacity-8 = "󰂂";
          ramp-capacity-9 = "󰁹";

          format-low = "<animation-low> <label-low>";
          format-low-foreground = "\${theme.fg-alert}";

          animation-low-0 = "󰂃";
          animation-low-1 = "󰂎";
          animation-low-framerate = "300";
        };
      };
    };
  };
}
