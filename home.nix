# Manage user accounts with home-manager.
{ pkgs, ... }: {
  imports = [ ./dconf.nix ];

  home.packages = with pkgs; [
    gnomeExtensions.material-shell
    dconf2nix
    starship
    lazygit
    bat
    exa
    fd
    fzf
    ripgrep
    neovim
    neovim-qt
    brave
    spotify
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      starship init fish | source
    '';
    shellAbbrs = {
      lg = "lazygit";
    };
  };

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
}
