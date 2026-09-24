{ inputs, lib, config, ... }: {
  imports = [ inputs.dms-plugin-registry.nixosModules.default ];

  options.hostOptions.desktopEnvironments.niri = with lib; {
    enable = mkEnableOption "Enable the niri compositor with the DankMaterialShell desktop shell";
  };

  config =
    let
      cfg = config.hostOptions.desktopEnvironments.niri;
    in
    lib.mkIf cfg.enable {
      # The infinite-scrolling Wayland compositor itself
      programs.niri.enable = true;

      # The DankMaterialShell - a batteries-included shell to make compositors
      # more like Desktop Environments
      programs.dms-shell = {
        enable = true;

        # The plugins to enable from the registry
        plugins = {
          # Do calculations in the DMS app launcher
          calculator.enable = true;

          # Manage Tailscale networks from the DMS topbar
          dankscale.enable = true;

          # View GitHub PRs and issues assigned to me from the DMS topbar
          githubNotifier.enable = true;
        };
      };

      # Allow DankMaterialShell to read the battery status
      services.upower.enable = true;

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Hint to electron apps to use Wayland
      };
    };
}
