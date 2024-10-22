{ pkgs, lib, config, ... }:
let
  cfg = config.hostOptions.desktopEnvironment.awesome;
in
{
  config = lib.mkIf cfg.enable {
    services.xserver = {
      windowManager.awesome = {
        enable = true;
      };
    };
  };
}
