{ config, ... }:
let
  cfg = config.hostOptions;
in
{
  imports = [
    # Utilities and tooling for multiple shells
    ./utils/starship.nix # The starship cross-shell prompt

    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ];

  # Set aliases to be used by all shells
  home-manager.users.${cfg.user}.home.shellAliases = {
    lg = "lazygit";
    ll = "eza -lah";
    gl = "git log --pretty=fuller";
    gll = "git log --pretty=fuller -1";
  };
}
