# Manage user accounts with home-manager.
{ pkgs, ... }: {
  imports = [ ./dconf.nix ];

  home.packages = with pkgs; [
    gnomeExtensions.material-shell
    dconf2nix
    starship
    git
    lazygit
    bat
    exa
    fd
    fzf
    ripgrep
    neovim
    neovim-qt
    brave
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      starship init fish | source
    '';
    shellAliases = {
      lg = "lazygit";
    };
  };
}
