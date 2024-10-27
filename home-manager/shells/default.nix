{ config, ... }:
let
  cfg = config.hostOptions;
in
{
  home.shellAliases = {
    lg = "lazygit";
    ll = "eza -lah";
  };

  programs.bash.enable = builtins.elem "bash" cfg.shells;

  imports = [
    ./zsh.nix
  ];
}
