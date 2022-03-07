# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "io/elementary/appcenter/settings" = {
      last-refresh-time = mkInt64 1628579862;
      window-maximized = false;
      window-position = mkTuple [ 4 555 ];
      window-size = mkTuple [ 954 520 ];
    };

    "org/gnome/calendar" = {
      active-view = "week";
    };

    "org/gnome/control-center" = {
      last-panel = "keyboard";
    };

    "org/gnome/desktop/app-folders/folders/Pop-Office" = {
      apps = [ "libreoffice-calc.desktop" "libreoffice-draw.desktop" "libreoffice-impress.desktop" "libreoffice-math.desktop" "libreoffice-startcenter.desktop" "libreoffice-writer.desktop" ];
      name = "Office";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/Pop-System" = {
      apps = [ "gnome-language-selector.desktop" "gnome-session-properties.desktop" "gnome-system-monitor.desktop" "im-config.desktop" "nm-connection-editor.desktop" "nvidia-settings.desktop" "org.gnome.baobab.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.PowerStats.desktop" "org.gnome.seahorse.Application.desktop" "software-properties-gnome.desktop" "system76-driver.desktop" "system76-firmware.desktop" ];
      name = "System";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/Pop-Utility" = {
      apps = [ "com.github.donadigo.eddy.desktop" "com.system76.Popsicle.desktop" "gucharmap.desktop" "info.desktop" "org.gnome.eog.desktop" "org.gnome.Evince.desktop" "org.gnome.Extensions.desktop" "org.gnome.FileRoller.desktop" "org.gnome.font-viewer.desktop" "org.gnome.Screenshot.desktop" "org.gnome.Totem.desktop" "pop-cosmic-applications.desktop" "pop-cosmic-launcher.desktop" "pop-cosmic-workspaces.desktop" "simple-scan.desktop" "yelp.desktop" ];
      name = "Utilities";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///usr/share/backgrounds/pop/kate-hazen-mort1mer.png";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      current = mkUint32 0;
      per-window = false;
      sources = [ (mkTuple [ "xkb" "us+euro" ]) ];
      xkb-options = [];
    };

    "org/gnome/desktop/interface" = {
      clock-format = "24h";
      clock-show-weekday = true;
      document-font-name = "Fira Code 11";
      enable-hot-corners = false;
      font-name = "Fira Code 10";
      gtk-im-module = "gtk-im-context-simple";
      gtk-theme = "Pop";
      icon-theme = "Pop";
      locate-pointer = false;
      show-battery-percentage = true;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "io-elementary-appcenter" "slack" ];
    };

    "org/gnome/desktop/notifications/application/io-elementary-appcenter" = {
      application-id = "io.elementary.appcenter.desktop";
    };

    "org/gnome/desktop/notifications/application/slack" = {
      application-id = "slack.desktop";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      report-technical-problems = false;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      lock-delay = mkUint32 0;
      picture-options = "zoom";
      picture-uri = "file:///usr/share/backgrounds/pop/kate-hazen-mort1mer.png";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 300;
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
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
      titlebar-font = "Fira Code Semi-Bold 10";
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
      network-monitor-gio-name = "";
    };

    "org/gnome/file-roller/dialogs/extract" = {
      recreate-folders = true;
      skip-newer = false;
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 250;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 473;
      window-width = 954;
    };

    "org/gnome/gedit/plugins" = {
      active-plugins = [ "docinfo" "sort" "filebrowser" "modelines" "spell" ];
    };

    "org/gnome/gedit/plugins/filebrowser" = {
      root = "file:///";
      tree-view = true;
      virtual-root = "file:///home/callum/repos/ansible/tasks";
    };

    "org/gnome/gedit/preferences/ui" = {
      show-tabs-mode = "auto";
    };

    "org/gnome/gedit/state/file-chooser" = {
      open-recent = false;
    };

    "org/gnome/gedit/state/window" = {
      bottom-panel-size = 140;
      side-panel-active-page = "GeditWindowDocumentsPanel";
      side-panel-size = 200;
      size = mkTuple [ 1912 998 ];
      state = 87040;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      experimental-features = [];
      workspaces-only-on-primary = true;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 954 473 ];
      maximized = false;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = mkUint32 3263;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      calculator = [ "<Super>c" ];
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>s";
      command = "slack";
      name = "Slack";
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

    "org/gnome/settings-daemon/plugins/xsettings" = {
      antialiasing = "grayscale";
      hinting = "slight";
    };

    "org/gnome/shell" = {
      favorite-apps = [ "firefox.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Terminal.desktop" "io.elementary.appcenter.desktop" "io.elementary.installer.desktop" "gnome-control-center.desktop" ];
      had-bluetooth-devices-setup = true;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-fixed = false;
      extend-height = false;
      intellihide = true;
      manualhide = true;
      multi-monitor = true;
    };

    "org/gnome/shell/extensions/pop-cosmic" = {
      show-applications-button = false;
      show-workspaces-button = false;
    };

    "org/gnome/shell/extensions/pop-shell" = {
      gap-inner = mkUint32 1;
      gap-outer = mkUint32 1;
      pop-monitor-left = [ "<Shift><Super>Left" "<Shift><Super>KP_Left" ];
      pop-monitor-right = [ "<Shift><Super>Right" "<Shift><Super>KP_Right" ];
      pop-workspace-down = [ "<Shift><Super>Down" "<Shift><Super>KP_Down" ];
      pop-workspace-up = [ "<Shift><Super>Up" "<Shift><Super>KP_Up" ];
      show-title = false;
      smart-gaps = true;
      tile-by-default = true;
      toggle-stacking-global = [];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Pop";
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [];
      toggle-overview = [ "<Super>w" ];
    };

    "org/gnome/system/location" = {
      enabled = false;
    };

    "org/gtk/settings/file-chooser" = {
      clock-format = "24h";
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 150;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 798 27 ];
      window-size = mkTuple [ 1096 856 ];
    };

  };
}
