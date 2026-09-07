{ ... }: {
  imports = [
    # Utilities and tooling for multiple shells
    ./utils

    ./fish.nix
  ];

  config = {
    # Set aliases to be used by all shells
    home.shellAliases = {
      lg = "lazygit";
      ll = "eza -lah";
      gl = "git log --pretty=fuller";
      gll = "git log --pretty=fuller -1";
    };
  };
}
