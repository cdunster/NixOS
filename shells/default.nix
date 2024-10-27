{ config, ... }:
let
  cfg = config.hostOptions;
in
{
  imports = [
    ./fish.nix
  ];

  users.users.${cfg.user}.shell = cfg.defaultShellPackage;
}
