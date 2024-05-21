{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        ",preferred,auto,1"
      ];
      exec-once = [
        "hyprpaper"
        "ags"
      ];
      misc.disable_hyprland_logo = true;
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "ags -t app_launcher";
      "$browser" = "brave";
      # (m) Mouse binds, these rely on mouse movement.
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      # (l) Binds that still work when the screen is locked.
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"
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

        "SUPER, Escape, exec, hyprlock"
        "SUPER, T, exec, $terminal"
        "SUPER, B, exec, $browser"
        "SUPER, Q, killactive"
        "SUPER, X, exit"
        "SUPER, F, exec, $fileManager"
        "SUPER, G, togglefloating"
        "SUPER SHIFT, G, togglefloating"
        "SUPER SHIFT, G, pin"
        "SUPER, R, exec, $menu"

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
