{ ... }: {
  imports = [
    # Utilities and tooling for multiple terminals
    ./utils/zellij.nix

    ./kitty.nix
    ./wezterm
  ];

  xdg.terminal-exec = {
    enable = true;
    settings.default = [
      "kitty.desktop"
      "org.wezfurlong.wezterm.desktop"
    ];
  };
}
