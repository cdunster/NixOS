{ config, ... }:
let
  user = config.hostOptions.user;
in
{
  home-manager.users.${user}.programs.helix = {
    enable = true;
  };
}
