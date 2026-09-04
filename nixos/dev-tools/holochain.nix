{ pkgs, lib, config, ... }: {
  options.hostOptions.devTools.holochain = with lib; {
    enable = mkEnableOption "Enable the tooling and config required to develop for Holochain";
  };

  config =
    let
      cfg = config.hostOptions.devTools.holochain;
      user = config.hostOptions.user;
    in
    lib.mkIf cfg.enable {
      # Settings added to /etc/nix/nix.conf
      nix.settings = {
        # Add the holochain caches
        substituters = [
          "https://holochain-ci.cachix.org"
          "https://holochain-wind-tunnel.cachix.org"
          "https://holochain-scaffolding-cli.cachix.org"

          # Use the new NixOS official binary cache (currently in beta)
          "https://aseipp-nix-cache.freetls.fastly.net"
        ];

        # Trust derivations from the official holochain caches
        trusted-public-keys = [
          "holochain-ci.cachix.org-1:5IUSkZc0aoRS53rfkvH9Kid40NpyjwCMCzwRTXy+QN8="
          "holochain-wind-tunnel.cachix.org-1:tnSm+7Y3hDKOc9xLdoVMuInMA2AQ0R/99Ucz5edYGJw="
          "holochain-scaffolding-cli.cachix.org-1:DznpFcPqqPqiP05k/0lT6qeQ/N3KOvKQW/EP4Pf3A2E="
        ];
      };

      programs.extra-container.enable = true; # Run declarative NixOS containers without host system rebuilds

      home-manager.users.${user}.home.packages = with pkgs; [
        mattermost-desktop # Desktop client Mattermost; a collaboration and chat app for businesses
        zoom-us # Video conferencing software
        discord # Chat desktop app for gamers and communities
        colmena # Simple and stateless NixOS deployment tool
      ];
    };
}
