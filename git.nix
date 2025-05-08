{ config, ... }:
let
  user = config.hostOptions.user;
in
{
  home-manager.users.${user}.programs.git = {
    enable = true;
    userName = "Callum Dunster";
    userEmail = "cdunster@users.noreply.github.com";
    lfs.enable = true;
    signing = {
      key = null;
      signByDefault = true;
    };
    ignores = [
      "Session.vim"
      ".cache"
      ".direnv"
    ];
    extraConfig = {
      credential.helper = "store";
      init.defaultBranch = "main";
      pull.ff = "only";
      safe.directory = [ "/etc/nixos" ];
      rerere.enabled = true;
    };
  };
}
