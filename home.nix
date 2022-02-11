# Manage user accounts with home-manager.
{ pkgs, ... }: {
  imports = [ ./dconf.nix ];

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

  programs.git = {
    enable = true;
    userName = "Callum Dunster";
    extraConfig = {
      credential.helper = "store";
      init.defaultBranch = "main";
      pull.ff = "only";
      "includeIf \"gitdir:~/repos/work/\"".path = "~/repos/work/.gitconfig";
      "includeIf \"gitdir:~/repos/personal/\"".path = "~/repos/personal/.gitconfig";
    };
  };

  home.file."repos/work/.gitconfig".text = ''
    [user]
        email = "callum.dunster@evbox.com";
  '';

  home.file."repos/personal/.gitconfig".text = ''
    [user]
        email = "cdunster@users.noreply.github.com";
  '';

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

  programs.neovim.enable = true;
}
