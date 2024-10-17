{ ... }: {
  home.shellAliases = {
    lg = "lazygit";
    ll = "eza -lah";
  };

  programs.bash.enable = true;

  imports = [
    ./fish.nix
    ./zsh.nix
  ];
}
