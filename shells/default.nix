{ config, ... }:
let
  user = config.hostOptions.user;
in
{
  imports = [
    # Utilities and tooling for multiple shells
    ./utils

    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ];

  # Set aliases to be used by all shells
  home-manager.users.${user}.home.shellAliases = {
    lg = "lazygit";
    ll = "eza -lah";
    gl = "git log --pretty=fuller";
    gll = "git log --pretty=fuller -1";
  };
}
