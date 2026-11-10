{ ... }: {
  imports = [
    # Utilities and tooling for multiple terminals
    ./utils/zellij.nix

    ./kitty.nix
  ];

  xdg.terminal-exec = {
    enable = true;
    settings.default = [
      "kitty.desktop"
    ];
  };
}
