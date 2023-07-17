{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    dotDir = ".config/zsh";
    initExtra = ''
      source ${config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/zsh/dracula-theme.zsh"}
    '';
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      lg = "lazygit";
      ll = "exa -lah";
      ls = "exa";
      cd = "z";
    };
  };

  # Make zsh the default shell
  # home.sessionVariables.SHELL = "${config.home.homeDirectory}/.nix-profile/bin/zsh";
}
