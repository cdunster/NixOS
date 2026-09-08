{ ... }: {
  config = {
    # Set user's fonts, need to be installed on the system
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "JetBrainsMono Nerd Font 10" ];
        monospace = [ "JetBrainsMono Nerd Font Mono 11" ];
      };
    };
  };
}
