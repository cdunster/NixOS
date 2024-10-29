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
      extraConfig = "startup_session launch.conf";
    };

    xdg.configFile."kitty/launch.conf".text = ''launch sh -c "tmux"'';
  };
}
