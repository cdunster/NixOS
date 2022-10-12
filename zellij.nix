{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
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
    };
  };
}
