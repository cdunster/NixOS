# Configure git using home-manager.
{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Callum Dunster";
    userEmail = "cdunster@users.noreply.github.com";
    lfs.enable = true;
    ignores = [
      "Session.vim"
      ".cache"
      ".direnv"
    ];
    extraConfig = {
      credential.helper = "store";
      init.defaultBranch = "main";
      pull.ff = "only";
    };
  };
}
