{ osConfig, ... }: {
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
    '';
  };

  xdg.configFile.cosmic-is-dark-mode = {
    target = "cosmic/com.system76.CosmicTheme.Mode/v1/is_dark";
    text = if osConfig.stylix.polarity == "dark" then "true" else "false";
  };
}
