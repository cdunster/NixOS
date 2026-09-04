{ config, ... }:
let
  user = config.hostOptions.user;
in
{
  home-manager.users.${user} = {
    programs.kitty = {
      enable = true;
      settings = {
        font_size = "12.0";
        font_family = "JetBrains Mono Nerd Font";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        hide_window_decorations = "yes";
      };
      keybindings = {
        "ctrl+tab" = "send_key ctrl+tab";
        "ctrl+shift+tab" = "send_key ctrl+shift+tab";
        "alt+c" = "send_key alt+c";
        "alt+shift+c" = "send_key alt+shift+c";
        "alt+9" = "send_key alt+9";
        "alt+shift+9" = "send_key alt+shift+9";
        "alt+0" = "send_key alt+0";
        "alt+shift+0" = "send_key alt+shift+0";
      };
      extraConfig = "startup_session launch.conf";
    };

    xdg.configFile."kitty/launch.conf".text = ''launch sh -c "zellij -l welcome"'';
  };
}
