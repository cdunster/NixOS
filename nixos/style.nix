{ inputs, pkgs, config, ... }: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  config = {
    # Style the system with stylix
    stylix = {
      enable = true;

      # Set the base colour-scheme used by the entire system and all users by default
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";

      # Set the system fonts
      fonts = {
        serif = config.stylix.fonts.monospace;

        sansSerif = config.stylix.fonts.monospace;

        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
