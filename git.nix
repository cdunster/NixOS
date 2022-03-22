# Configure git using home-manager.
{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Callum Dunster";
    lfs.enable = true;
    ignores = [
      "Session.vim"
    ];
    includes = [
      {
        condition = "gitdir:~/repos/work/";
        contents = {
          user.email = "callum.dunster@evbox.com";
        };
      }
      {
        condition = "gitdir:~/repos/personal/";
        contents = {
          user.email = "cdunster@users.noreply.github.com";
        };
      }
    ];
    extraConfig = {
      credential.helper = "store";
      init.defaultBranch = "main";
      pull.ff = "only";
    };
  };
}
