{ ... }: {
  imports = [
    # Utilities and tooling for multiple terminals
    ./utils/tmux.nix
    ./utils/zellij.nix

    ./kitty.nix
    ./wezterm
  ];
}
