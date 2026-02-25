{ config, ... }:
let
  user = config.hostOptions.user;
in
{
  home-manager.users.${user}.programs.zellij = {
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
                    _children = [{ GoToNextTab = { }; }];
                  };
                }
                {
                  bind = {
                    _args = [ "Ctrl Shift Tab" ];
                    _children = [{ GoToPreviousTab = { }; }];
                  };
                }
                {
                  bind = {
                    _args = [ "Alt h" "Alt Left" ];
                    _children = [{ MoveFocus = "Left"; }];
                  };
                }
                {
                  bind = {
                    _args = [ "Alt j" "Alt Down" ];
                    _children = [{ MoveFocus = "Down"; }];
                  };
                }
                {
                  bind = {
                    _args = [ "Alt k" "Alt Up" ];
                    _children = [{ MoveFocus = "Up"; }];
                  };
                }
                {
                  bind = {
                    _args = [ "Alt l" "Alt Right" ];
                    _children = [{ MoveFocus = "Right"; }];
                  };
                }
                {
                  bind = {
                    _args = [ "Alt g" ];
                    _children = [{ NewTab = { name = "Lazygit"; layout = "lazygit"; }; }];
                  };
                }
                {
                  bind = {
                    _args = [ "Alt z" ];
                    _children = [{ ToggleFocusFullscreen = { }; }];
                  };
                }
                {
                  bind = {
                    _args = [ "Alt v" ];
                    _children = [{ NewPane = "Down"; }];
                  };
                }
                {
                  bind = {
                    _args = [ "Alt s" ];
                    _children = [{ NewPane = "Right"; }];
                  };
                }
                {
                  bind = {
                    _args = [ "Alt t" ];
                    _children = [{ NewTab = { }; }];
                  };
                }
                {
                  bind = {
                    _args = [ "Alt w" ];
                    _children = [
                      {
                        LaunchOrFocusPlugin = {
                          _args = [ "session-manager" ];
                          _children = [
                            { floating = true; }
                            { move_to_focused_tab = true; }
                          ];
                        };
                      }
                    ];
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
