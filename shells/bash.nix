{ pkgs, lib, config, ... }:

with lib;
{
  options.hostOptions.shells.bash = {
    default = mkEnableOption "Make bash the default shell. Only one shell can be specified as the default";
  };

  config =
    let
      cfg = config.hostOptions.shells.bash;
      user = config.hostOptions.user;
    in
    {
      # Set the default shell of the main user to bash
      users.users.${user}.shell = mkIf cfg.default pkgs.bash;

      # Configure the bash shell via home-manager
      home-manager.users.${user}.programs.bash = {
        enable = true;
      };
    };
}
