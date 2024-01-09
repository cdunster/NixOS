# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "com/github/donadigo/eddy" = {
      mime-types = [ "application/vnd.debian.binary-package" "application/x-deb" ];
    };

    "com/mattjakeman/ExtensionManager" = {
      last-used-version = "0.4.2";
    };

    "com/system76/hidpi" = {
      mode = "hidpi";
    };

    "io/elementary/appcenter/settings" = {
      cached-drivers = [ ];
    };

    "net/flyingpimonster/Camera" = {
      capture-mode = "picture";
    };

    "org/gnome/Geary" = {
      migrated-config = true;
    };

    "org/gnome/Totem" = {
      active-plugins = [ "recent" "vimeo" "skipto" "screenshot" "mpris" "save-file" "open-directory" "movie-properties" "autoload-subtitles" "variable-rate" "screensaver" "rotation" "apple-trailers" ];
      subtitle-encoding = "UTF-8";
    };

    "org/gnome/Weather" = {
      automatic-location = true;
      locations = "[<(uint32 2, <('Rijswijk, South Holland', '', false, [(0.90835009039569248, 0.075377654980920278)], @a(dd) [])>)>, <(uint32 2, <('Amsterdam', 'EHAM', true, [(0.91280719879303418, 0.083194033496160544)], [(0.91367986341903151, 0.085812027374152042)])>)>]";
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
    };

    "org/gnome/calendar" = {
      active-view = "week";
    };

    "org/gnome/desktop/a11y/applications" = {
      screen-magnifier-enabled = false;
      screen-reader-enabled = false;
    };

    "org/gnome/desktop/a11y/magnifier" = {
      mouse-tracking = "proportional";
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
      mru-sources = [ (mkTuple [ "xkb" "us+euro" ]) (mkTuple [ "ibus" "mozc-jp" ]) ];
      per-window = false;
      sources = [ (mkTuple [ "xkb" "us+euro" ]) ];
      xkb-options = [ "caps:none" ];
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

    "org/gnome/desktop/notifications" = {
      application-children = [ "gnome-control-center" "io-elementary-appcenter" "org-gnome-nautilus" "teams" "org-gnome-terminal" "gnome-power-panel" "org-gnome-tweaks" "gnome-network-panel" "org-gnome-eog" "org-gnome-calculator" "org-gnome-baobab" "org-gnome-calendar" "brave-browser" "gnome-system-monitor" "org-gnome-gedit" "org-gnome-diskutility" "com-mattjakeman-extensionmanager" "org-gnome-shell-extensions" "org-gnome-evince" "org-gnome-font-viewer" "org-gnome-totem" "org-gnome-fileroller" "jetbrains-studio" "simple-scan" "teams-for-linux" "com-system76-popsicle" "org-gnome-weather" "kitty" "gucharmap" "picotech-picoscope" "org-gnome-geary" "net-flyingpimonster-camera" "nm-connection-editor" "godot4" ];
      show-banners = true;
    };

    "org/gnome/desktop/notifications/application/brave-browser" = {
      application-id = "brave-browser.desktop";
    };

    "org/gnome/desktop/notifications/application/com-mattjakeman-extensionmanager" = {
      application-id = "com.mattjakeman.ExtensionManager.desktop";
    };

    "org/gnome/desktop/notifications/application/com-system76-popsicle" = {
      application-id = "com.system76.Popsicle.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-control-center" = {
      application-id = "gnome-control-center.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-network-panel" = {
      application-id = "gnome-network-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-system-monitor" = {
      application-id = "gnome-system-monitor.desktop";
    };

    "org/gnome/desktop/notifications/application/godot4" = {
      application-id = "Godot4.desktop";
    };

    "org/gnome/desktop/notifications/application/gucharmap" = {
      application-id = "gucharmap.desktop";
    };

    "org/gnome/desktop/notifications/application/io-elementary-appcenter" = {
      application-id = "io.elementary.appcenter.desktop";
    };

    "org/gnome/desktop/notifications/application/jetbrains-studio" = {
      application-id = "jetbrains-studio.desktop";
    };

    "org/gnome/desktop/notifications/application/kitty" = {
      application-id = "kitty.desktop";
    };

    "org/gnome/desktop/notifications/application/net-flyingpimonster-camera" = {
      application-id = "net.flyingpimonster.Camera.desktop";
    };

    "org/gnome/desktop/notifications/application/nm-connection-editor" = {
      application-id = "nm-connection-editor.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-baobab" = {
      application-id = "org.gnome.baobab.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-calculator" = {
      application-id = "org.gnome.Calculator.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-calendar" = {
      application-id = "org.gnome.Calendar.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-diskutility" = {
      application-id = "org.gnome.DiskUtility.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-eog" = {
      application-id = "org.gnome.eog.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-evince" = {
      application-id = "org.gnome.Evince.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-fileroller" = {
      application-id = "org.gnome.FileRoller.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-font-viewer" = {
      application-id = "org.gnome.font-viewer.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-geary" = {
      application-id = "org.gnome.Geary.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-gedit" = {
      application-id = "org.gnome.gedit.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-shell-extensions" = {
      application-id = "org.gnome.Shell.Extensions.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-terminal" = {
      application-id = "org.gnome.Terminal.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-totem" = {
      application-id = "org.gnome.Totem.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-tweaks" = {
      application-id = "org.gnome.tweaks.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-weather" = {
      application-id = "org.gnome.Weather.desktop";
    };

    "org/gnome/desktop/notifications/application/picotech-picoscope" = {
      application-id = "picotech-picoscope.desktop";
    };

    "org/gnome/desktop/notifications/application/simple-scan" = {
      application-id = "simple-scan.desktop";
    };

    "org/gnome/desktop/notifications/application/teams-for-linux" = {
      application-id = "teams-for-linux.desktop";
    };

    "org/gnome/desktop/notifications/application/teams" = {
      application-id = "teams.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.477941;
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
      lock-delay = mkUint32 30;
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
      theme-name = "freedesktop";
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
      action-middle-click-titlebar = "none";
      button-layout = "appmenu:close";
      num-workspaces = 10;
      resize-with-right-button = true;
      titlebar-font = "JetBrainsMono Nerd Font 10";
    };

    "org/gnome/eog/ui" = {
      sidebar = false;
    };

    "org/gnome/eog/view" = {
      background-color = "rgb(0,0,0)";
      use-background-color = true;
    };

    "org/gnome/evince" = {
      document-directory = "@ms 'file:///home/callum/Downloads'";
    };

    "org/gnome/evince/default" = {
      continuous = true;
      dual-page = false;
      dual-page-odd-left = false;
      enable-spellchecking = true;
      fullscreen = false;
      inverted-colors = false;
      show-sidebar = false;
      sidebar-page = "thumbnails";
      sidebar-size = 132;
      sizing-mode = "automatic";
      window-ratio = mkTuple [ 1.602618 0.618846 ];
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
      name-column-width = 247;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
    };

    "org/gnome/gedit/plugins" = {
      active-plugins = [ "filebrowser" "sort" "spell" "docinfo" "openlinks" "modelines" ];
    };

    "org/gnome/gedit/plugins/filebrowser" = {
      root = "file:///";
      tree-view = true;
      virtual-root = "file:///media/callum/flash-boot";
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

    "org/gnome/gedit/state/window" = {
      bottom-panel-size = 140;
      side-panel-active-page = "GeditWindowDocumentsPanel";
      side-panel-size = 200;
      state = 87168;
    };

    "org/gnome/gnome-screenshot" = {
      delay = 0;
      include-pointer = false;
    };

    "org/gnome/gnome-system-monitor" = {
      current-tab = "processes";
      maximized = false;
      network-total-in-bits = false;
      show-dependencies = false;
      show-whose-processes = "user";
    };

    "org/gnome/gnome-system-monitor/disktreenew" = {
      col-6-visible = true;
      col-6-width = 0;
    };

    "org/gnome/gnome-system-monitor/proctree" = {
      columns-order = [ 0 1 2 3 4 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 ];
      sort-col = 8;
      sort-order = 0;
    };

    "org/gnome/libgnomekbd/preview" = {
      height = 647;
      width = 1464;
      x = 430;
      y = 180;
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

    "org/gnome/nm-applet/eap/02e19021-ed25-4103-a7ff-6c442312867e" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/08980dee-1a86-4e93-80a4-048f7556474f" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/0b8d7590-9add-4009-875c-96312145fc30" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/1d67e8d2-b8a3-36d7-90b2-de297d50456f" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/c0dcdb8d-8e8f-458a-a77e-d6425855908f" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/cbda7b47-dd3e-4948-bc30-eb29a7405b81" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
    };

    "org/gnome/nm-applet/eap/d9656154-380c-39fb-a3ff-8e6236e8b3bc" = {
      ignore-ca-cert = false;
      ignore-phase2-ca-cert = false;
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
      app-picker-layout = "[{'org.gnome.Geary.desktop': <{'position': <0>}>, 'org.gnome.Contacts.desktop': <{'position': <1>}>, 'org.gnome.Weather.desktop': <{'position': <2>}>, 'jetbrains-studio.desktop': <{'position': <3>}>, 'appimagelaunchersettings.desktop': <{'position': <4>}>, 'appimagekit_a5335e7684f151ddc76670025cf7bafd-arduino-ide.desktop': <{'position': <5>}>, 'bloomrpc.desktop': <{'position': <6>}>, 'org.gnome.Calculator.desktop': <{'position': <7>}>, 'brave-browser.desktop': <{'position': <8>}>, 'org.gnome.gedit.desktop': <{'position': <9>}>, 'org.gnome.Calendar.desktop': <{'position': <10>}>, 'net.flyingpimonster.Camera.desktop': <{'position': <11>}>, 'sqlitebrowser.desktop': <{'position': <12>}>, 'com.mattjakeman.ExtensionManager.desktop': <{'position': <13>}>, 'fish.desktop': <{'position': <14>}>, 'flutter_openurl.desktop': <{'position': <15>}>, 'org.freecadweb.FreeCAD.desktop': <{'position': <16>}>, 'gimp.desktop': <{'position': <17>}>, 'Godot4.desktop': <{'position': <18>}>, 'Helix.desktop': <{'position': <19>}>, 'kitty.desktop': <{'position': <20>}>, 'kreya_kreya.desktop': <{'position': <21>}>, 'teams-for-linux.desktop': <{'position': <22>}>, 'monodoc-http.desktop': <{'position': <23>}>}, {'setup-mozc.desktop': <{'position': <0>}>, 'nvim.desktop': <{'position': <1>}>, 'picotech-picoscope.desktop': <{'position': <2>}>, 'ranger.desktop': <{'position': <3>}>, 'saleae-logic-2.desktop': <{'position': <4>}>, 'spotify.desktop': <{'position': <5>}>, 'STM32CubeProgrammer.desktop': <{'position': <6>}>, 'STM32TrustedPackageCreator.desktop': <{'position': <7>}>, 'Pop-System': <{'position': <8>}>, 'org.gnome.tweaks.desktop': <{'position': <9>}>, 'code.desktop': <{'position': <10>}>, 'org.gnome.FileRoller.desktop': <{'position': <11>}>, 'gucharmap.desktop': <{'position': <12>}>, 'simple-scan.desktop': <{'position': <13>}>, 'org.gnome.Evince.desktop': <{'position': <14>}>, 'com.github.donadigo.eddy.desktop': <{'position': <15>}>, 'org.gnome.Extensions.desktop': <{'position': <16>}>, 'org.gnome.font-viewer.desktop': <{'position': <17>}>, 'yelp.desktop': <{'position': <18>}>, 'org.gnome.eog.desktop': <{'position': <19>}>, 'com.system76.Popsicle.desktop': <{'position': <20>}>, 'info.desktop': <{'position': <21>}>, 'libreoffice-startcenter.desktop': <{'position': <22>}>, 'nm-connection-editor.desktop': <{'position': <23>}>}, {'org.gnome.Totem.desktop': <{'position': <0>}>, 'libreoffice-calc.desktop': <{'position': <1>}>, 'org.gnome.baobab.desktop': <{'position': <2>}>, 'org.gnome.DiskUtility.desktop': <{'position': <3>}>, 'gnome-language-selector.desktop': <{'position': <4>}>, 'org.gnome.seahorse.Application.desktop': <{'position': <5>}>, 'org.gnome.PowerStats.desktop': <{'position': <6>}>, 'gnome-session-properties.desktop': <{'position': <7>}>, 'gnome-system-monitor.desktop': <{'position': <8>}>}]";
      command-history = [ "r" ];
      disable-user-extensions = false;
      disabled-extensions = [ "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "window-list@gnome-shell-extensions.gcampax.github.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "apps-menu@gnome-shell-extensions.gcampax.github.com" "native-window-placement@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "ding@rastersoft.com" "pop-cosmic@system76.com" "pop-shell@system76.com" "system76-power@system76.com" "ubuntu-appindicators@ubuntu.com" "cosmic-dock@system76.com" "cosmic-workspaces@system76.com" "popx11gestures@system76.com" "emoji-selector@maestroschan.fr" "user-theme@gnome-shell-extensions.gcampax.github.com" "auto-move-windows@gnome-shell-extensions.gcampax.github.com" "sound-output-device-chooser@kgshank.net" "bluetooth-quick-connect@bjarosze.gmail.com" ];
      had-bluetooth-devices-setup = true;
      last-selected-power-profile = "power-saver";
      welcome-dialog-last-shown-version = "42.3.1";
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [ "spotify.desktop:10" "teams.desktop:1" ];
    };

    "org/gnome/shell/extensions/bluetooth-quick-connect" = {
      keep-menu-on-toggle = true;
      show-battery-value-on = true;
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
      recently-used = [ ];
    };

    "org/gnome/shell/extensions/pop-cosmic" = {
      overlay-key-action = "LAUNCHER";
      show-applications-button = false;
      show-workspaces-button = true;
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

    "org/gnome/shell/extensions/sound-output-device-chooser" = {
      hide-menu-icons = false;
      hide-on-single-device = true;
      icon-theme = "monochrome";
      integrate-with-slider = false;
      omit-device-origins = true;
      show-input-devices = true;
      show-input-slider = true;
      show-output-devices = true;
      show-profiles = false;
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
      locations = "[<(uint32 2, <('Rijswijk, South Holland', '', false, [(0.90835009039569248, 0.075377654980920278)], @a(dd) [])>)>, <(uint32 2, <('Amsterdam', 'EHAM', true, [(0.91280719879303418, 0.083194033496160544)], [(0.91367986341903151, 0.085812027374152042)])>)>]";
    };

    "org/gnome/simple-scan" = {
      document-type = "photo";
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/terminal/legacy" = {
      theme-variant = "system";
    };

    "org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
      background-color = "rgb(0,43,54)";
      font = "JetBrainsMono Nerd Font 12";
      foreground-color = "rgb(131,148,150)";
      use-theme-colors = true;
      visible-name = "System Theme";
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/gtk4/settings/debug" = {
      inspector-warning = true;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 186;
      sort-column = "size";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
    };

    "org/gtk/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 1.0 1.0 ]) ];
      selected-color = mkTuple [ true 0.960784 ];
    };

    "org/gtk/settings/file-chooser" = {
      clock-format = "24h";
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 194;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
    };

  };
}
