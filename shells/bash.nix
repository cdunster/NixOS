{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.hostOptions.shells.bash;
  user = config.hostOptions.user;
in
{
  config = mkIf cfg.enable {
    # Set the default shell of the main user to bash
    users.users.${user}.shell = mkIf cfg.default pkgs.bash;

    # Configure the bash shell via home-manager
    home-manager.users.${user}.programs.bash = {
      enable = true;
    };
  };
}
