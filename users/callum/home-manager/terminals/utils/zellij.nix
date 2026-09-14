{ ... }: {
  programs.zellij = {
    enable = true;
    layouts = {
      lazygit = {
        layout._children = [
          {
            pane = {
              _props = { size = 1; borderless = true; };
              _children = [{ plugin._props.location = "zellij:tab-bar"; }];
            };
          }
          {
            pane._props = {
              command = "lazygit";
              close_on_exit = true;
            };
          }
        ];
      };
    };
    settings = {
      keybinds = {
        _props.clear-defaults = true;
        _children = [
          {
            locked._children = [
              {
                bind = {
                  _args = [ "Alt Esc" ];
                  SwitchToMode = "Normal";
                };
              }
            ];
          }
          {
            shared_except = {
              _args = [ "locked" ];
              _children = [
                {
                  bind = {
                    _args = [ "Alt Esc" ];
                    SwitchToMode = "Locked";
                  };
                }
                {
                  bind = {
                    _args = [ "Ctrl Tab" ];
                    GoToNextTab = { };
                  };
                }
                {
                  bind = {
                    _args = [ "Ctrl Shift Tab" ];
                    GoToPreviousTab = { };
                  };
                }
                {
                  bind = {
                    _args = [ "Alt h" "Alt Left" ];
                    MoveFocus = "Left";
                  };
                }
                {
                  bind = {
                    _args = [ "Alt j" "Alt Down" ];
                    MoveFocus = "Down";
                  };
                }
                {
                  bind = {
                    _args = [ "Alt k" "Alt Up" ];
                    MoveFocus = "Up";
                  };
                }
                {
                  bind = {
                    _args = [ "Alt l" "Alt Right" ];
                    MoveFocus = "Right";
                  };
                }
                {
                  bind = {
                    _args = [ "Alt Shift h" "Alt Shift Left" ];
                    Resize = "Increase Left";
                  };
                }
                {
                  bind = {
                    _args = [ "Alt Shift j" "Alt Shift Down" ];
                    Resize = "Increase Down";
                  };
                }
                {
                  bind = {
                    _args = [ "Alt Shift k" "Alt Shift Up" ];
                    Resize = "Increase Up";
                  };
                }
                {
                  bind = {
                    _args = [ "Alt Shift l" "Alt Shift Right" ];
                    Resize = "Increase Right";
                  };
                }
                {
                  bind = {
                    _args = [ "Alt g" ];
                    NewTab = { name = "Lazygit"; layout = "lazygit"; };
                  };
                }
                {
                  bind = {
                    _args = [ "Alt z" ];
                    ToggleFocusFullscreen = { };
                  };
                }
                {
                  bind = {
                    _args = [ "Alt v" ];
                    NewPane = "Down";
                  };
                }
                {
                  bind = {
                    _args = [ "Alt s" ];
                    NewPane = "Right";
                  };
                }
                {
                  bind = {
                    _args = [ "Alt t" ];
                    NewTab = { };
                  };
                }
                {
                  bind = {
                    _args = [ "Alt Shift q" ];
                    CloseFocus = { };
                  };
                }
                {
                  bind = {
                    _args = [ "Alt Shift t" ];
                    CloseTab = { };
                  };
                }
                {
                  bind = {
                    _args = [ "Alt w" ];
                    LaunchOrFocusPlugin = {
                      _args = [ "session-manager" ];
                      _children = [
                        { floating = true; }
                        { move_to_focused_tab = true; }
                      ];
                    };
                  };
                }
                {
                  bind = {
                    _args = [ "Alt o" ];
                    LaunchOrFocusPlugin = {
                      _args = [ "zellij:layout-manager" ];
                      _children = [
                        { floating = true; }
                        { move_to_focused_tab = true; }
                      ];
                    };
                  };
                }
                {
                  bind = {
                    _args = [ "Alt u" ];
                    LaunchOrFocusPlugin = {
                      _args = [ "zellij:share" ];
                      _children = [
                        { floating = true; }
                        { move_to_focused_tab = true; }
                      ];
                    };
                  };
                }
              ];
            };
          }
        ];
      };
    };
  };
}
