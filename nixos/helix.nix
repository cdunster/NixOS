{ config, pkgs, ... }:
let
  user = config.hostOptions.user;
in
{
  home-manager.users.${user}.programs.helix = {
    enable = true;
    extraPackages = with pkgs;[
      # LSPs
      clang-tools # C/C++
      pyright # Python
      lua-language-server # Lua
      vscode-langservers-extracted # HTML/CSS/JSON/ESLint
      rust-analyzer # Rust
      nixd # Nix
      gopls #GoLang
    ];
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
