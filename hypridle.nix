{ ... }: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # Avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # Lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # To avoid having to press a key twice to turn on the display.
      };
      listener = [
        {
          timeout = 30;
          on-timeout = "brightnessctl -s set 10"; # Set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r"; # Monitor backlight restore.
        }

        {
          # Turn off keyboard backlight.
          timeout = 30;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # Turn off keyboard backlight.
          on-resume = "brightnessctl -rd rgb:kbd_backlight"; # Turn on keyboard backlight.
        }

        {
          timeout = 20;
          on-timeout = "pidof hyprlock && hyprctl dispatch dpms off"; # Screen off if the session is locked.
          on-resume = "hyprctl dispatch dpms on"; # Screen on when activity is detected again.
        }

        {
          timeout = 60;
          on-timeout = "hyprctl dispatch dpms off"; # Screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # Screen on when activity is detected after timeout has fired.
        }

        {
          timeout = 65;
          on-timeout = "loginctl lock-session"; # Lock screen when timeout has passed
        }

        {
          timeout = 1200;
          on-timeout = "systemctl suspend"; # Suspend pc
        }
      ];
    };
  };
}
