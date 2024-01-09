{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    theme = "Dracula";
    settings = {
      font_size = "12.0";
      font_family = "JetBrains Mono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      hide_window_decorations = "yes";
    };
  };
}
