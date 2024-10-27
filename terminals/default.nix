{ ... }: {
  imports = [
    # Utilities and tooling for multiple terminals
    ./utils/tmux.nix

    ./kitty.nix
    ./wezterm
  ];
}
