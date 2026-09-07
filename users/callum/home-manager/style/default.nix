{ ... }: {
  imports = [
    ./catppuccin.nix
  ];

  config = {
    # Set user's fonts, need to be installed on the system
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "JetBrainsMono Nerd Font 10" ];
        monospace = [ "JetBrainsMono Nerd Font Mono 11" ];
      };
    };

    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
      gtk4 = {
        theme = null;
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
    };
  };
}
