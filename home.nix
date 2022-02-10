# Manage user accounts with home-manager.
{ pkgs, ... }: {
  imports = [ ./dconf.nix ];

  home.packages = with pkgs; [
    gnomeExtensions.material-shell
    dconf2nix
    git
    lazygit
    bat
    exa
    neovim
    neovim-qt
    brave
  ];

  programs.fish = {
    enable = true;
  };
}
