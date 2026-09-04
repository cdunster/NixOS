{ pkgs, ... }: {
  config = {
    # Manage networks with networkmanager.
    networking.networkmanager = {
      enable = true;

      # Enable OpenVPN support.
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };

  };
}
