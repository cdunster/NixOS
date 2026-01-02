{ config, ... }:
let
  user = config.hostOptions.user;
in
{
  home-manager.users.${user}.programs.git = {
    enable = true;
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
    settings = {
      user = {
        name = "Callum Dunster";
        email = "cdunster@users.noreply.github.com";
      };
      extraConfig = {
        credential.helper = "store";
        init.defaultBranch = "main";
        pull.ff = "only";
        safe.directory = [ "/etc/nixos" ];
        rerere.enabled = true;
      };
    };
  };
}
