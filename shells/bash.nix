{ lib, config, ... }:

with lib;

let
  cfg = config.hostOptions;
in
{
  config = mkIf (builtins.elem "bash" cfg.shells) {
    # Configure the bash shell via home-manager
    home-manager.users.${cfg.user}.programs.bash = {
      enable = true;
    };
  };
}
