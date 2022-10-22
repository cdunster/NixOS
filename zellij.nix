{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      copy_on_select = false;
      themes.dracula = {
        fg = [ 248 248 242 ];
        bg = [ 40 42 54 ];
        black = [ 0 0 0 ];
        gray = [ 68 71 90 ];
        red = [ 255 85 85 ];
        green = [ 80 250 123 ];
        yellow = [ 241 250 140 ];
        blue = [ 98 114 164 ];
        magenta = [ 255 121 198 ];
        cyan = [ 139 233 253 ];
        white = [ 255 255 255 ];
        orange = [ 255 184 108 ];
      };
      theme = "dracula";
      default_mode = "Locked";
      keybinds =
      let
        movement_binds = [
          {
            action = [ { MoveFocus = "Left"; } ];
            key = [ { Alt = "h"; } { Alt = "Left"; } ];
          }
          {
            action = [ { MoveFocus = "Down"; } ];
            key = [ { Alt = "j"; } { Alt = "Down"; } ];
          }
          {
            action = [ { MoveFocus = "Up"; } ];
            key = [ { Alt = "k"; } { Alt = "Up"; } ];
          }
          {
            action = [ { MoveFocus = "Right"; } ];
            key = [ { Alt = "l"; } { Alt = "Right"; } ];
          }
          {
            action = [ "GoToNextTab" ];
            key = [ { Alt = "]"; } ];
          }
          {
            action = [ "GoToPreviousTab" ];
            key = [ { Alt = "["; } ];
          }
        ];
        resize_binds = [
          {
            action = [ { Resize = "Left"; } ];
            key = [ { Alt = "H"; } ];
          }
          {
            action = [ { Resize = "Down"; } ];
            key = [ { Alt = "J"; } ];
          }
          {
            action = [ { Resize = "Up"; } ];
            key = [ { Alt = "K"; } ];
          }
          {
            action = [ { Resize = "Right"; } ];
            key = [ { Alt = "L"; } ];
          }
        ];
        global_binds =
          movement_binds
          ++ resize_binds
          ++ [
            {
              action = [ { SwitchToMode = "Locked"; } ];
              key = [ "Esc" ];
            }
          ];
      in {
        unbind = true;
        normal = global_binds ++ [
          {
            action = [ { SwitchToMode = "Pane"; } ];
            key = [ { Char = "p"; } ];
          }
          {
            action = [ { SwitchToMode = "Resize"; } ];
            key = [ { Char = "r"; } ];
          }
          {
            action = [ { SwitchToMode = "Tab"; } ];
            key = [ { Char = "t"; } ];
          }
          {
            action = [ { NewPane = null; } { SwitchToMode = "Locked"; } ];
            key = [ { Char = "n"; } ];
          }
          {
            action = [ "ToggleFocusFullscreen" { SwitchToMode = "Locked"; } ];
            key = [ { Char = "z"; } ];
          }
          {
            action = [ "ToggleFloatingPanes" { SwitchToMode = "Locked"; } ];
            key = [ { Char = "f"; } ];
          }
        ];
        locked = global_binds ++ [
          {
            action = [ { SwitchToMode = "Normal"; } ];
            key = [ { Alt = " "; } ];
          }
        ];
        pane = global_binds ++ [
          {
            action = [ { NewPane = "Left"; } { SwitchToMode = "Locked"; } ];
            key = [ { Char = "h"; } "Left" ];
          }
          {
            action = [ { NewPane = "Down"; } { SwitchToMode = "Locked"; } ];
            key = [ { Char = "j"; } "Down" ];
          }
          {
            action = [ { NewPane = "Up"; } { SwitchToMode = "Locked"; } ];
            key = [ { Char = "k"; } "Up" ];
          }
          {
            action = [ { NewPane = "Right"; } { SwitchToMode = "Locked"; } ];
            key = [ { Char = "l"; } "Right" ];
          }
          {
            action = [ { NewPane = null; } { SwitchToMode = "Locked"; } ];
            key = [ { Char = "n"; } ];
          }
          {
            action = [ "CloseFocus" { SwitchToMode = "Locked"; } ];
            key = [ { Char = "x"; } ];
          }
        ];
        tab = global_binds ++ [
          {
            action = [ { NewTab = null; } { SwitchToMode = "Locked"; } ];
            key = [ { Char = "n"; } ];
          }
          {
            action = [ "CloseTab" { SwitchToMode = "Locked"; } ];
            key = [ { Char = "x"; } ];
          }
        ];
      };
    };
  };
}
