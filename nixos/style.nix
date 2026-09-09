{ inputs, pkgs, ... }: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  config = {
    # Style the system with stylix
    stylix = {
      enable = true;

      # Set the base colour-scheme used by the entire system and all users by default
      base16Scheme = "${pkgs.base16-schemes}/share/themes/ia-light.yaml";

      # Set the system fonts
      fonts = {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };

        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };

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
