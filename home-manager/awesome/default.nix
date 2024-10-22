{ lib, config, ... }:
let
  cfg = config.hostOptions.desktopEnvironment.awesome;
in
{
  xdg.configFile."awesome/rc.lua".source = lib.mkIf cfg.enable ./rc.lua;
}
