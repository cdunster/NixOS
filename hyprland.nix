{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        layout = "master";
        gaps_out = 10;
      };
      monitor = [
        ",preferred,auto,1"
      ];
      exec-once = [
        "hyprpaper"
        "ags"
        "hypridle"
      ];
      misc = {
        disable_hyprland_logo = true;
        new_window_takes_over_fullscreen = 2; # Opening a new window over a full-screen one un-full-screens it.
      };
      windowrulev2 = [
        "float,class:(org.gnome.Calculator)"
        "float,title:^(Brave)$"
        "float,class:^(pavucontrol)$"
        "workspace 1,class:(teams-for-linux)"
        "workspace 2,class:(Slack)"
        "workspace 10,title:(Spotify)"
      ];
      # Global variables for the config.
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "ags -t app_launcher";
      "$browser" = "brave";
      "$calculator" = "gnome-calculator";
      # (m) Mouse binds, these rely on mouse movement.
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      # (l) Binds that still work when the screen is locked.
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ];
      # (e) Binds that repeat when held and (l) still work when the screen is locked.
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bind = [
        "ALT, Tab, workspace, +1"
        "ALT SHIFT, Tab, workspace, -1"
        "SUPER, Tab, focuscurrentorlast"

        "SUPER, Escape, exec, loginctl lock-session"
        "SUPER, T, exec, $terminal"
        "SUPER, B, exec, $browser"
        "SUPER, C, exec, $calculator"
        "SUPER, V, exec, ags -t central"
        "SUPER, Z, fullscreen, 1" # Maximise the current window
        "SUPER, Q, killactive"
        "SUPER, X, exit"
        "SUPER, F, exec, $fileManager"
        "SUPER, G, togglefloating"
        "SUPER SHIFT, G, togglefloating"
        "SUPER SHIFT, G, pin"
        "SUPER, R, exec, $menu"

        # Open work applications
        "SUPER SHIFT, W, exec, [workspace 1 silent;noanim] teams-for-linux"
        "SUPER SHIFT, W, exec, [workspace 2 silent;noanim] slack"
        "SUPER SHIFT, W, exec, [workspace 4 silent;noanim] $terminal"
        "SUPER SHIFT, W, exec, [workspace 3] $browser"

        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        builtins.concatLists (builtins.genList
          (
            x:
            let
              ws = builtins.toString (x + 1);
              key = builtins.toString (if x < 9 then x + 1 else 0);
            in
            [
              "SUPER, ${key}, workspace, ${ws}"
              "SUPER SHIFT, ${key}, movetoworkspace, ${ws}"
            ]
          )
          10)
      );
    };
  };
}
