{ lib, osConfig, ... }: {
  config = {
    # If dms-shell is enabled, let it manage GTK and Qt theming instead of Stylix
    stylix.targets = lib.mkIf osConfig.programs.dms-shell.enable {
      gtk.enable = false;
      qt.enable = false;
    };

    wayland.windowManager.niri = lib.mkIf osConfig.programs.niri.enable {
      enable = true;

      settings = {
        # Enable tap inputs on touchpads
        input.touchpad = {
          tap = { };
          tap-button-map = "left-right-middle";
        };

        # Enable switching to previous workspace by trying to switch to the current one
        input.workspace-auto-back-and-forth = { };

        binds = {
          "Mod+Shift+Slash".show-hotkey-overlay = { };

          "Mod+r" = {
            _props.hotkey-overlay-title = "Open the App Launcher";
            spawn = [ "dms" "ipc" "call" "spotlight" "toggle" ];
          };

          "Mod+t" = {
            _props.hotkey-overlay-title = "Open the default Terminal";
            spawn = "xdg-terminal-exec";
          };

          "Mod+b" = {
            _props.hotkey-overlay-title = "Open the default Browser";
            spawn = [ "xdg-open" "http://" ];
          };

          "Mod+q".close-window = { };

          "Mod+w".toggle-overview = { };

          "Mod+m".maximize-window-to-edges = { };
          "Mod+f".maximize-column = { };
          "Mod+Ctrl+f".expand-column-to-available-width = { };
          "Mod+Shift+f".fullscreen-window = { };

          "Mod+a".consume-or-expel-window-left = { };
          "Mod+e".consume-or-expel-window-right = { };
          "Mod+y".toggle-column-tabbed-display = { };
          "Mod+g".toggle-window-floating = { };

          "Mod+h".focus-column-left = { };
          "Mod+j".focus-window-down = { };
          "Mod+k".focus-window-up = { };
          "Mod+l".focus-column-right = { };

          "Mod+Left".focus-column-left = { };
          "Mod+Down".focus-window-down = { };
          "Mod+Up".focus-window-up = { };
          "Mod+Right".focus-column-right = { };

          "Mod+Ctrl+h".move-column-left = { };
          "Mod+Ctrl+j".move-window-down = { };
          "Mod+Ctrl+k".move-window-up = { };
          "Mod+Ctrl+l".move-column-right = { };

          "Mod+Ctrl+Left".move-column-left = { };
          "Mod+Ctrl+Down".move-window-down = { };
          "Mod+Ctrl+Up".move-window-up = { };
          "Mod+Ctrl+Right".move-column-right = { };

          "Mod+Shift+h".set-column-width = "-10%";
          "Mod+Shift+j".set-window-height = "-10%";
          "Mod+Shift+k".set-window-height = "+10%";
          "Mod+Shift+l".set-column-width = "+10%";

          "Mod+Shift+Left".set-column-width = "-10%";
          "Mod+Shift+Down".set-window-height = "-10%";
          "Mod+Shift+Up".set-window-height = "+10%";
          "Mod+Shift+Right".set-column-width = "+10%";

          "Mod+n".focus-workspace-down = { };
          "Mod+p".focus-workspace-up = { };
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          "Mod+Shift+n".move-column-to-workspace-down = { };
          "Mod+Shift+p".move-column-to-workspace-up = { };
          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;

          "Print".screenshot = { _props.show-pointer = false; };
          "Shift+Print".screenshot-window = { _props.show-pointer = false; };

          "Mod+Escape" = {
            _props.hotkey-overlay-title = "Lock the Screen";
            spawn = [ "dms" "ipc" "call" "lock" "lock" ];
          };

          "Mod+x" = {
            _props.hotkey-overlay-title = "Open the Power Menu";
            spawn = [ "dms" "ipc" "call" "powermenu" "toggle" ];
          };

          "XF86AudioRaiseVolume" = {
            _props.allow-when-locked = true;
            spawn = [ "dms" "ipc" "call" "audio" "increment" "5" ];
          };
          "XF86AudioLowerVolume" = {
            _props.allow-when-locked = true;
            spawn = [ "dms" "ipc" "call" "audio" "decrement" "5" ];
          };
          "XF86AudioMute" = {
            _props.allow-when-locked = true;
            spawn = [ "dms" "ipc" "call" "audio" "mute" ];
          };
          "XF86AudioMicMute" = {
            _props.allow-when-locked = true;
            spawn = [ "dms" "ipc" "call" "mic" "mute" ];
          };
          "XF86MonBrightnessUp" = {
            _props.allow-when-locked = true;
            spawn = [ "dms" "ipc" "call" "brightness" "increment" "5" "backlight:amdgpu_bl1" ];
          };
          "XF86MonBrightnessDown" = {
            _props.allow-when-locked = true;
            spawn = [ "dms" "ipc" "call" "brightness" "decrement" "5" "backlight:amdgpu_bl1" ];
          };
          "XF86AudioPlay" = {
            _props.allow-when-locked = true;
            spawn = [ "dms" "ipc" "call" "mpris" "playPause" ];
          };
          "XF86AudioNext" = {
            _props.allow-when-locked = true;
            spawn = [ "dms" "ipc" "call" "mpris" "next" ];
          };
          "XF86AudioPrev" = {
            _props.allow-when-locked = true;
            spawn = [ "dms" "ipc" "call" "mpris" "previous" ];
          };
          "XF86AudioStop" = {
            _props.allow-when-locked = true;
            spawn = [ "dms" "ipc" "call" "mpris" "stop" ];
          };
        };
      };
    };
  };
}
