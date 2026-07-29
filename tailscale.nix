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
      services.tailscale = {
        # Enable the Tailscale client daemon
        enable = true;

        # Set this as a client to accept subnet routers and exit nodes
        useRoutingFeatures = "client";
      };

      home-manager.users.${user} = {
        programs.gnome-shell = mkIf gnomeEnabled {
          extensions = with pkgs.gnomeExtensions; [
            { package = tailscale-qs; } # Quick settings entry for controlling Tailscale
          ];
        };
      };
    };
}
