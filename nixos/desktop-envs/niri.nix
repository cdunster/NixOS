{ inputs, lib, config, pkgs, ... }: {
  imports = [ inputs.dux-plugin-registry.nixosModules.default ];

  options.hostOptions.desktopEnvironments.niri = with lib; {
    enable = mkEnableOption "Enable the niri compositor with the Dux desktop shell";
  };

  config =
    let
      cfg = config.hostOptions.desktopEnvironments.niri;
    in
    lib.mkIf cfg.enable {
      # The infinite-scrolling Wayland compositor itself
      programs.niri.enable = true;

      # A batteries-included wayland shell to make compositors more like
      # Desktop Environments
      programs.dux-shell = {
        enable = true;

        # This systemd start up is unreliable with a fish login shell, which
        # leaves dux-shell.service without WAYLAND_DISPLAY. Disable it for now and
        # start via Niri instead.
        systemd.enable = false;

        # The plugins to enable from the registry
        plugins = {
          # Do calculations in the Dux app launcher
          calculator.enable = true;

          # Manage Tailscale networks from the Dux Shell topbar
          dankscale.enable = true;

          # View GitHub PRs and issues assigned to me from the Dux Shell topbar
          githubNotifier.enable = true;
        };
      };

      environment.systemPackages = with pkgs; [
        dux-calendar # The official calendar backend for Dux Shell
      ];

      # Allow Dux Shell to read the battery status
      services.upower.enable = true;

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Hint to electron apps to use Wayland
      };
    };
}
