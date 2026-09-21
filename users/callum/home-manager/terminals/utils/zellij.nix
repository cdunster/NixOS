{ lib, config, ... }: {
  programs.zellij = {
    enable = true;

    # The theme that Stylix creates has some issues that need fixing
    themes.stylix.themes.default = {
      # This is a tabs' on-hover bg. By default, it uses the same colour as the fg
      ribbon_unselected.emphasis_1 = lib.mkForce "#${config.lib.stylix.colors.base03}";

      # This is unset by Stylix so it defaults to the text colour which is too dark
      frame_unselected = {
        # The unselected-pane's frame colour
        base = "#${config.lib.stylix.colors.base03}";

        # The following are currently unused
        emphasis_0 = "#${config.lib.stylix.colors.base03}";
        emphasis_1 = "#${config.lib.stylix.colors.base03}";
        emphasis_2 = "#${config.lib.stylix.colors.base03}";
        emphasis_3 = "#${config.lib.stylix.colors.base03}";
      };

      # The session-manager's selected-row background the default is too dark
      list_selected.background = lib.mkForce "#${config.lib.stylix.colors.base02}";
    };

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
            normal._children = [
              {
                bind = {
                  _args = [ "Alt a" ];
                  SwitchToMode = "Scroll";
                };
              }
            ];
          }
          {
            scroll._children = [
              {
                bind = {
                  _args = [ "Alt Esc" ];
                  SwitchToMode = "Normal";
                };
              }
              {
                bind = {
                  _args = [ "j" ];
                  ScrollDown = { };
                };
              }
              {
                bind = {
                  _args = [ "k" ];
                  ScrollUp = { };
                };
              }
              {
                bind = {
                  _args = [ "Ctrl d" ];
                  HalfPageScrollDown = { };
                };
              }
              {
                bind = {
                  _args = [ "Ctrl u" ];
                  HalfPageScrollUp = { };
                };
              }
              {
                bind = {
                  _args = [ "PageDown" ];
                  PageScrollDown = { };
                };
              }
              {
                bind = {
                  _args = [ "PageUp" ];
                  PageScrollUp = { };
                };
              }
              {
                bind = {
                  _args = [ "[" ];
                  ScrollToPreviousPrompt = { };
                };
              }
              {
                bind = {
                  _args = [ "]" ];
                  ScrollToNextPrompt = { };
                };
              }
              {
                bind = {
                  _args = [ "Ctrl Home" ];
                  ScrollToTop = { };
                };
              }
              {
                bind = {
                  _args = [ "q" "Ctrl End" ];
                  ScrollToBottom = { };
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
