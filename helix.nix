{ ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "dracula";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        color-modes = true;
        whitespace.render = {
          space = "all";
          nbsp = "all";
          tab = "all";
        };
      };
    };
  };
}
