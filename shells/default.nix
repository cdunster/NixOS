{ ... }: {
  home.shellAliases = {
    lg = "lazygit";
    ll = "eza -lah";
    ls = "eza";
  };

  programs.bash.enable = true;

  imports = [
    ./fish.nix
  ];
}
