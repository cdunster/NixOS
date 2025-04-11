{ pkgs, lib, config, ... }:

with lib;
{
  options.hostOptions.tailscale = {
    enable = mkEnableOption "Enable the Tailscale client";
  };

  config =
    let
      cfg = config.hostOptions.tailscale;
      user = config.hostOptions.user;
      gnomeEnabled = config.hostOptions.desktopEnvironments.gnome.enable;
    in
    mkIf cfg.enable {
      # Enable the Tailscale client daemon
      services.tailscale.enable = true;

      home-manager.users.${user} = {
        programs.gnome-shell = mkIf gnomeEnabled {
          extensions = with pkgs.gnomeExtensions; [
            { package = tailscale-qs; } # Quick settings entry for controlling Tailscale
          ];
        };
      };
    };
}
