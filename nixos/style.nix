{ inputs, pkgs, lib, config, ... }: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  config = {
    # Style the system with stylix
    stylix = {
      enable = true;

      # Set the base colour-scheme used by the entire system and all users by default
      base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/rose-pine-dawn.yaml";

      # Set the system light/dark mode
      polarity = lib.mkDefault "light";

      # Set the system cursor theme used by all users by default
      cursor = {
        package = pkgs.rose-pine-cursor;
        name = lib.mkDefault "BreezeX-RosePineDawn-Linux";
        size = 24;
      };

      # Set the system fonts
      fonts = {
        serif = config.stylix.fonts.sansSerif;

        sansSerif = {
          package = pkgs.nerd-fonts.caskaydia-cove;
          name = "CaskaydiaCove Nerd Font Propo";
        };

        monospace = {
          package = pkgs.nerd-fonts.caskaydia-cove;
          name = "CaskaydiaCove Nerd Font Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };

    # A NixOS specialisation that changes the colour scheme to a dark variant
    specialisation.dark.configuration.stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
      polarity = "dark";
      cursor.name = "BreezeX-RosePine-Linux";
    };

    # Allow switching configurations without a password, so that Darkman can switch between
    # the base and dark specialisations to control the colour-scheme
    security.sudo.extraRules = [{
      groups = [ "wheel" ];
      commands = [
        { command = "/run/current-system/specialisation/dark/bin/switch-to-configuration switch"; options = [ "NOPASSWD" ]; }
        { command = "/nix/var/nix/profiles/system/bin/switch-to-configuration switch"; options = [ "NOPASSWD" ]; }
      ];
    }];
  };
}
