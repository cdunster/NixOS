# Manage user accounts with home-manager.
{ pkgs, ... }: {
  imports = [ ./dconf.nix ];

  home.packages = with pkgs; [
    gnomeExtensions.material-shell
    git
    bat
    neovim
    neovim-qt
    brave
  ];

  programs.bash.enable = true;
}
