{ config, ... }:
let
  cfg = config.hostOptions;
in
{
  users.users.${cfg.user}.shell = cfg.defaultShellPackage;
}
