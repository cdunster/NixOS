{ ... }: {
  imports = [
    # Utilities and tooling for multiple terminals
    ./utils/zellij.nix

    ./kitty.nix
    ./wezterm
  ];
}
