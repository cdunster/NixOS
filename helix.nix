{ config, ... }:
let
  user = config.hostOptions.user;
in
{
  home-manager.users.${user}.programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        cursorline = true;
        trim-trailing-whitespace = true;
        cursor-shape = {
          insert = "bar";
        };
        whitespace = {
          render = {
            space = "all";
            tab = "all";
            nbsp = "none";
            nnbsp = "none";
            newline = "none";
          };
        };
        indent-guides = {
          render = true;
        };
      };
    };
  };
}
