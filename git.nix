# Configure git using home-manager.
{ pkgs, ... }: {
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
