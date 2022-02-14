# Manage user accounts with home-manager.
{ pkgs, ... }: {
  imports = [
    ./dconf.nix
    ./neovim.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    gnomeExtensions.material-shell
    dconf2nix
    fd
    ripgrep
    neovim-qt
    brave
    spotify
  ];

  programs.kitty = {
    enable = true;
    theme = "Darkside";
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      lg = "lazygit";
      ll = "exa -lah";
    };
    shellInit = ''
      set -g fish_greeting ""
    '';
  };

  programs.starship.enable = true;

  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "skip";
      gui = {
        showCommandLog = false;
      };
    };
  };

  programs.bat.enable = true;

  programs.exa.enable = true;

  programs.fzf.enable = true;

  programs.direnv.enable = true;
}
