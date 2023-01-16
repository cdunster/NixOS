# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "com/mattjakeman/ExtensionManager" = {
      last-used-version = "0.4.0";
    };

    "com/system76/hidpi" = {
      mode = "hidpi";
    };

    "org/gnome/calculator" = {
      accuracy = 9;
      angle-units = "degrees";
      base = 10;
      button-mode = "programming";
      number-format = "automatic";
      show-thousands = false;
      show-zeroes = false;
      source-currency = "DZD";
      source-units = "degree";
      target-currency = "DZD";
      target-units = "radian";
      word-size = 64;
    };

    "org/gnome/calendar" = {
      active-view = "week";
    };

    "org/gnome/desktop/applications/terminal" = {
      exec = "/home/callum/.nix-profile/bin/kitty";
      exec-arg = "";
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/callum/.local/share/backgrounds/deer_sunset.jpg";
      picture-uri-dark = "file:///home/callum/.local/share/backgrounds/deer_sunset.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      current = mkUint32 0;
      per-window = false;
      sources = [ (mkTuple [ "xkb" "us+euro" ]) ];
      xkb-options = [ ];
    };

    "org/gnome/desktop/interface" = {
      clock-format = "24h";
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      cursor-theme = "Dracula-cursors";
      document-font-name = "JetBrainsMono Nerd Font 11";
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      font-name = "JetBrainsMono Nerd Font 10";
      gtk-im-module = "gtk-im-context-simple";
      gtk-theme = "Dracula";
      icon-theme = "Pop";
      locate-pointer = false;
      monospace-font-name = "JetBrainsMono Nerd Font Mono 11";
      show-battery-percentage = true;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.4779411764705883;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      speed = 0.184;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      disable-microphone = false;
      report-technical-problems = false;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      lock-delay = mkUint32 0;
      picture-options = "zoom";
      picture-uri = "file:///home/callum/.local/share/backgrounds/deer_sunset.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 300;
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
      theme-name = "Pop";
    };

    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [ ];
      cycle-windows = [ "<Super>Tab" ];
      cycle-windows-backward = [ "<Shift><Super>Tab" ];
      move-to-monitor-down = [ "<Shift><Super>j" ];
      move-to-monitor-left = [ "<Shift><Super>h" ];
      move-to-monitor-right = [ "<Shift><Super>l" ];
      move-to-monitor-up = [ "<Shift><Super>k" ];
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-10 = [ "<Shift><Super>0" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      move-to-workspace-5 = [ "<Shift><Super>5" ];
      move-to-workspace-6 = [ "<Shift><Super>6" ];
      move-to-workspace-7 = [ "<Shift><Super>7" ];
      move-to-workspace-8 = [ "<Shift><Super>8" ];
      move-to-workspace-9 = [ "<Shift><Super>9" ];
      switch-applications = [ "<Alt>Tab" ];
      switch-applications-backward = [ "<Shift><Alt>Tab" ];
      switch-input-source = [ ];
      switch-input-source-backward = [ ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-10 = [ "<Super>0" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      switch-to-workspace-9 = [ "<Super>9" ];
      switch-to-workspace-down = [ "<Primary><Super>Down" "<Primary><Super>KP_Down" ];
      switch-to-workspace-up = [ "<Primary><Super>Up" "<Primary><Super>KP_Up" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:close";
      num-workspaces = 10;
      titlebar-font = "JetBrainsMono Nerd Font 10";
    };

    "org/gnome/eog/ui" = {
      sidebar = false;
    };

    "org/gnome/eog/view" = {
      background-color = "rgb(0,0,0)";
      use-background-color = true;
    };

    "org/gnome/gedit/preferences/editor" = {
      insert-spaces = true;
      scheme = "dracula";
      tabs-size = mkUint32 4;
      wrap-last-split-mode = "word";
    };

    "org/gnome/gedit/preferences/ui" = {
      show-tabs-mode = "auto";
    };

    "org/gnome/gnome-screenshot" = {
      delay = 0;
      include-pointer = false;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      edge-tiling = false;
      experimental-features = [ ];
      workspaces-only-on-primary = true;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      search-filter-time-type = "last_modified";
      search-view = "list-view";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = mkUint32 3263;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      calculator = [ "<Super>c" ];
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/PopLaunch1" = {
      binding = "Launch1";
      command = "gnome-control-center wifi";
      name = "WiFi";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>n";
      command = "nvim-qt";
      name = "Neovim";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>x";
      command = "gnome-session-quit --power-off";
      name = "Shutdown";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      ambient-enabled = false;
      sleep-inactive-ac-timeout = 1800;
      sleep-inactive-ac-type = "suspend";
      sleep-inactive-battery-timeout = 1800;
      sleep-inactive-battery-type = "suspend";
    };

    "org/gnome/shell" = {
      disabled-extensions = [ "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "apps-menu@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "ding@rastersoft.com" "pop-cosmic@system76.com" "pop-shell@system76.com" "system76-power@system76.com" "ubuntu-appindicators@ubuntu.com" "cosmic-dock@system76.com" "cosmic-workspaces@system76.com" "popx11gestures@system76.com" "emoji-selector@maestroschan.fr" "user-theme@gnome-shell-extensions.gcampax.github.com" ];
      welcome-dialog-last-shown-version = "42.3.1";
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-fixed = false;
      extend-height = false;
      intellihide = true;
      manualhide = true;
      multi-monitor = true;
    };

    "org/gnome/shell/extensions/emoji-selector" = {
      always-show = true;
      emojisize = 20;
      nbcols = 15;
      position = "top";
    };

    "org/gnome/shell/extensions/pop-cosmic" = {
      show-applications-button = false;
      show-workspaces-button = false;
    };

    "org/gnome/shell/extensions/pop-shell" = {
      activate-launcher = [ "<Super>space" ];
      active-hint = false;
      gap-inner = mkUint32 1;
      gap-outer = mkUint32 1;
      pop-monitor-left = [ "<Shift><Super>Left" "<Shift><Super>KP_Left" ];
      pop-monitor-right = [ "<Shift><Super>Right" "<Shift><Super>KP_Right" ];
      pop-workspace-down = [ "<Shift><Super>Down" "<Shift><Super>KP_Down" ];
      pop-workspace-up = [ "<Shift><Super>Up" "<Shift><Super>KP_Up" ];
      show-title = false;
      smart-gaps = true;
      tile-by-default = true;
      toggle-stacking-global = [ ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Dracula";
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [ ];
      toggle-overview = [ "<Super>w" ];
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
      locations = "[<(uint32 2, <('Amsterdam', 'EHAM', true, [(0.91280719879303418, 0.083194033496160544)], [(0.91367986341903151, 0.085812027374152042)])>)>]";
    };

    "org/gnome/system/location" = {
      enabled = false;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/debug" = {
      inspector-warning = true;
    };

    "org/gtk/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 1.0 1.0 ]) ];
      selected-color = mkTuple [ true 0.9607843137254902 ];
    };

    "org/gtk/settings/file-chooser" = {
      clock-format = "24h";
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 150;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
    };

  };
}
