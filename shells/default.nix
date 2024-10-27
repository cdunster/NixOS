{ config, ... }:
let
  cfg = config.hostOptions;
in
{
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ];

  # Set aliases to be used by all shells
  home-manager.users.${cfg.user}.home.shellAliases = {
    lg = "lazygit";
    ll = "eza -lah";
  };
}
