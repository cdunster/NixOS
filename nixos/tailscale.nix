{ lib, config, ... }:

with lib;
{
  options.hostOptions.tailscale = {
    enable = mkEnableOption "Enable the Tailscale client";
  };

  config =
    let
      cfg = config.hostOptions.tailscale;
    in
    mkIf cfg.enable {
      services.tailscale = {
        # Enable the Tailscale client daemon
        enable = true;

        # Set this as a client to accept subnet routers and exit nodes
        useRoutingFeatures = "client";
      };

      # Enable the firewall using nftables
      networking.nftables.enable = true;
      networking.firewall = {
        enable = true;
        # Always allow traffic from your Tailscale network
        trustedInterfaces = [ config.services.tailscale.interfaceName ];
        # Allow the Tailscale UDP port through the firewall
        allowedUDPPorts = [ config.services.tailscale.port ];
      };

      # Force tailscaled to use nftables
      systemd.services.tailscaled.serviceConfig.Environment = [
        "TS_DEBUG_FIREWALL_MODE=nftables"
      ];

      # Prevent systemd from waiting for network online
      systemd.network.wait-online.enable = false;
      boot.initrd.systemd.network.wait-online.enable = false;
    };
}
