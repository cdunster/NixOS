{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    theme = "Dracula";
    settings = {
      font_size = "12.0";
      font_family = "FiraCode Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      # For the FiraCode font features, see: https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets
      # This will stylise (in order) 'a' 'g' 'i' 'r' '@' '&' '<= >=' '\\' '=~ !~'
      "font_features FiraCodeNerdFontComplete-Regular" = "+cv01 +cv02 +cv06 +ss01 +ss05 +ss03 +ss02 +ss06 +ss07";
      "font_features FiraCodeNerdFontComplete-Bold" = "+cv01 +cv02 +cv06 +ss01 +ss05 +ss03 +ss02 +ss06 +ss07";
    };
  };
}
