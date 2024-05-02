{ inputs, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        ",preferred,auto,1"
      ];
      exec-once = [
        # Set the background image.
        "swaybg -i ${./images/backgrounds/deer_sunset.jpg} -m center"
      ];
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";
      "$browser" = "brave";
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      bind = [
        "ALT, Tab, workspace, +1"
        "ALT SHIFT, Tab, workspace, -1"
        "SUPER, Tab, focuscurrentorlast"

        "SUPER, T, exec, $terminal"
        "SUPER, B, exec, $browser"
        "SUPER, Q, killactive"
        "SUPER, M, exit"
        "SUPER, F, exec, $fileManager"
        "SUPER, G, togglefloating"
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
