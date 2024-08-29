# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "ca/desrt/dconf-editor" = {
      show-warning = false;
    };

    "com/mattjakeman/ExtensionManager" = {
      last-used-version = "0.5.1";
    };

    "org/gnome/calculator" = {
      button-mode = "programming";
    };

    "org/gnome/calendar" = {
      active-view = "month";
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

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      cursor-theme = "catppuccin-frappe-dark-cursors";
      document-font-name = "JetBrainsMono Nerd Font 11";
      enable-hot-corners = false;
      font-name = "JetBrainsMono Nerd Font 10";
      monospace-font-name = "JetBrainsMono Nerd Font Mono 10";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      speed = 0.25;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [ ];
      close = [ "<Super>q" ];
      cycle-windows = [ "<Super>Tab" ];
      cycle-windows-backward = [ "<Shift><Super>Tab" ];
      minimize = [ ];
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
      move-to-workspace-down = [ "<Shift><Super>j" ];
      move-to-workspace-last = [ "<Shift><Super>n" ];
      move-to-workspace-left = [ "<Shift><Super>h" ];
      move-to-workspace-right = [ "<Shift><Super>l" ];
      move-to-workspace-up = [ "<Shift><Super>k" ];
      switch-applications = [ "<Alt>Tab" ];
      switch-applications-backward = [ "<Shift><Alt>Tab" ];
      switch-group = [ "<Super>Above_Tab" "<Alt>Above_Tab" ];
      switch-group-backward = [ "<Shift><Super>Above_Tab" "<Shift><Alt>Above_Tab" ];
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
      switch-to-workspace-last = [ "<Super>n" ];
      switch-to-workspace-left = [ "<Control><Super>h" ];
      switch-to-workspace-right = [ "<Control><Super>l" ];
      switch-to-workspace-up = [ "<Primary><Super>Up" "<Primary><Super>KP_Up" ];
      toggle-maximized = [ "<Super>m" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 5;
      resize-with-right-button = true;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = false;
      experimental-features = [ ];
      workspaces-only-on-primary = true;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ ];
      toggle-tiled-right = [ ];
    };

    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [ ];
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = mkUint32 3263;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      calculator = [ "<Super>c" ];
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" ];
      screensaver = [ "<Super>Escape" ];
      www = [ "<Super>b" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "kitty";
      name = "Open kitty terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>f";
      command = "nautilus";
      name = "File Explorer";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>x";
      command = "gnome-session-quit --power-off";
      name = "Shutdown";
    };

    "org/gnome/shell" = {
      enabled-extensions = [ "pop-shell@system76.com" "auto-move-windows@gnome-shell-extensions.gcampax.github.com" "trayIconsReloaded@selfmade.pl" ];
      favorite-apps = [ ];
      last-selected-power-profile = "power-saver";
      welcome-dialog-last-shown-version = "46.3.1";
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [ "spotify.desktop:1" ];
    };

    "org/gnome/shell/extensions/pop-shell" = {
      activate-launcher = [ ];
      fullscreen-launcher = true;
      mouse-cursor-focus-location = mkUint32 4;
      show-title = false;
      smart-gaps = true;
      tile-by-default = true;
      toggle-stacking-global = [ ];
      toggle-tiling = [ ];
    };

    "org/gnome/shell/extensions/trayIconsReloaded" = {
      icon-margin-horizontal = 4;
      icon-padding-horizontal = 0;
      icon-size = 16;
      icons-limit = 10;
      invoke-to-workspace = false;
      position-weight = 1;
      tray-margin-left = 0;
      tray-position = "left";
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [ ];
      open-new-window-application-1 = [ ];
      open-new-window-application-2 = [ ];
      open-new-window-application-3 = [ ];
      open-new-window-application-4 = [ ];
      open-new-window-application-5 = [ ];
      open-new-window-application-6 = [ ];
      open-new-window-application-7 = [ ];
      open-new-window-application-8 = [ ];
      open-new-window-application-9 = [ ];
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      switch-to-application-5 = [ ];
      switch-to-application-6 = [ ];
      switch-to-application-7 = [ ];
      switch-to-application-8 = [ ];
      switch-to-application-9 = [ ];
      toggle-message-tray = [ "<Super>v" ];
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gtk/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 1.0 1.0 ]) ];
      selected-color = mkTuple [ true 0.960784 ];
    };

  };
}
