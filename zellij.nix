{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      copy_on_select = false;
      themes.dracula = {
        fg = [ 248 248 242 ];
        bg = [ 40 42 54 ];
        black = [ 40 42 54 ];
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
      default_layout = "compact";
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
          ++ resize_binds;
      in {
        unbind = true;
        Normal = global_binds ++ [
          {
            action = [ { SwitchToMode = "Locked"; } ];
            key = [ "Esc" ];
          }
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
            action = [ { SwitchToMode = "EnterSearch"; } { SearchInput = [ 0 ]; } ];
            key = [ { Char = "/"; } ];
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
          {
            action = [ "Quit" ];
            key = [ { Char = "q"; } ];
          }
        ];
        Locked = global_binds ++ [
          {
            action = [ { SwitchToMode = "Normal"; } ];
            key = [ { Alt = " "; } ];
          }
        ];
        Pane = global_binds ++ [
          {
            action = [ { SwitchToMode = "Locked"; } ];
            key = [ "Esc" ];
          }
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
            action = [ { SwitchToMode = "RenamePane"; } { PaneNameInput = [ 0 ]; } ];
            key = [ { Char = "r"; } ];
          }
          {
            action = [ "CloseFocus" { SwitchToMode = "Locked"; } ];
            key = [ { Char = "x"; } ];
          }
        ];
        RenamePane = [
          {
            action = [ { SwitchToMode = "Locked"; } ];
            key = [ { Char = "\n"; } ];
          }
          {
            action = [ "UndoRenamePane" { SwitchToMode = "Locked"; } ];
            key = [ "Esc" ];
          }
        ];
        Tab = global_binds ++ [
          {
            action = [ { SwitchToMode = "Locked"; } ];
            key = [ "Esc" ];
          }
          {
            action = [ { NewTab = null; } { SwitchToMode = "Locked"; } ];
            key = [ { Char = "n"; } ];
          }
          {
            action = [ { NewTab = { name = "lazygit"; run = { command = { cmd = "lazygit"; }; }; }; } { SwitchToMode = "Locked"; } ];
            key = [ { Char = "g"; } ];
          }
          {
            action = [ { SwitchToMode = "RenameTab"; } { TabNameInput = [ 0 ]; } ];
            key = [ { Char = "r"; } ];
          }
          {
            action = [ "CloseTab" { SwitchToMode = "Locked"; } ];
            key = [ { Char = "x"; } ];
          }
        ];
        RenameTab = [
          {
            action = [ { SwitchToMode = "Locked"; } ];
            key = [ { Char = "\n"; } ];
          }
          {
            action = [ "UndoRenameTab" { SwitchToMode = "Locked"; } ];
            key = [ "Esc" ];
          }
        ];
        EnterSearch = [
          {
            action = [ { SwitchToMode = "Locked"; } ];
            key = [ "Esc" ];
          }
          {
            action = [ { SwitchToMode = "Search"; } ];
            key = [ { Char = "\n"; } ];
          }
        ];
        Search = global_binds ++ [
          {
            action = [ { SwitchToMode = "Locked"; } ];
            key = [ "Esc" ];
          }
          {
            action = [ { Search = "Down"; } ];
            key = [ { Char = "n"; } ];
          }
          {
            action = [ { Search = "Up"; } ];
            key = [ { Char = "N"; } ];
          }
          {
            action = [ { SwitchToMode = "EnterSearch"; } { SearchInput = [ 0 ]; } ];
            key = [ { Char = "/"; } ];
          }
        ];
      };
    };
  };

  xdg.configFile = {
    "zellij/layouts/compact.yaml".source = ./zellij/compact.yaml;
  };
}
