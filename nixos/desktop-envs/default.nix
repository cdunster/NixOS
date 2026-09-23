{ ... }: {
  imports = [
    ./cosmic.nix # The COSMIC Desktop Environment
    ./niri.nix # The Niri compositor with the DankMaterialShell desktop shell enabled
  ];

  # Enable managing dconf with NixOS and home-manager
  programs.dconf.enable = true;
}
