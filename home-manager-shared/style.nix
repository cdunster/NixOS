{ osConfig, pkgs, ... }: {
  config = {
    services.darkman = {
      enable = true;

      # Amsterdam, used to calculate sunrise/sunset times
      settings = {
        lat = 52.3676;
        lng = 4.9041;
      };

      # Flip the system between the base (light) and "dark" NixOS specialisations
      # on every mode change
      scripts.specialisation-switch = ''
        if [ "$1" = "dark" ]; then
          sudo /run/current-system/specialisation/dark/bin/switch-to-configuration switch
        else
          sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
        fi

        # Force any running Neovim sessions to re-apply the new colour scheme
        for sock in "''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"/nvim.*.0; do
          [ -S "$sock" ] || continue
          ${pkgs.neovim}/bin/nvim --server "$sock" --remote-expr \
            "luaeval(\"(function() require('config.recolour').reload() end)()\")" \
            >/dev/null 2>&1 || true
        done
      '';
    };

    xdg.configFile.cosmic-is-dark-mode = {
      target = "cosmic/com.system76.CosmicTheme.Mode/v1/is_dark";
      text = if osConfig.stylix.polarity == "dark" then "true" else "false";
    };
  };
}
