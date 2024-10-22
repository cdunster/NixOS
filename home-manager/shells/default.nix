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
    ./fish.nix
    ./zsh.nix
  ];
}
