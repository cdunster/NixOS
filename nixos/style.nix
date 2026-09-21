{ inputs, pkgs, lib, config, ... }: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  config = {
    # Style the system with stylix
    stylix = {
      enable = true;

      # Set the base colour-scheme used by the entire system and all users by default
      base16Scheme = lib.mkDefault {
        scheme = "Custom Light Colourscheme";
        slug = "custom-light-colourscheme";
        variant = "light";
        palette = {
          base00 = "#f6f6f4";
          base01 = "#edeae9";
          base02 = "#c5c5c5";
          base03 = "#999999";
          base04 = "#8f8f8f";
          base05 = "#252525"; # Text
          base06 = "#1e1e1e";
          base07 = "#141414";
          base08 = "#c04000"; # Red
          base09 = "#d47e30"; # Peach/Orange
          base0A = "#ba8e23"; # Yellow
          base0B = "#2e6f40"; # Green
          base0C = "#069494"; # Cyan
          base0D = "#366899"; # Blue
          base0E = "#8e4585"; # Magenta
          base0F = "#4666b4"; # Brown
        };
      };

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
