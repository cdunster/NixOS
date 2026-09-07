{ ... }: {
  imports = [
    ./cosmic.nix # The COSMIC Desktop Environment
  ];

  # Enable managing dconf with NixOS and home-manager
  programs.dconf.enable = true;
}
