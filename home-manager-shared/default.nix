{ pkgs, lib, osConfig, ... }: {
  imports = [
    ./cosmic-de
    ./git.nix
  ];

  config =
    let
      isDconfEnabled = osConfig.programs.dconf.enable;
      isDockerEnabled = osConfig.virtualisation.docker.enable;
      isBootloaderLanzaboote = osConfig.boot.lanzaboote.enable;
    in
    {
      # Let home-manager manage its own installation.
      programs.home-manager.enable = true;

      # Enable the keyring secrets manager.
      services.gnome-keyring.enable = true;

      # The version of Home-manager used.
      home.stateVersion = "22.11";

      # Enable the Brave browser
      programs.brave.enable = true;

      # Enable lazydocker TUI to manager docker if docker itself is enabled
      programs.lazydocker.enable = isDockerEnabled;

      # Enable GNU Privacy Guard to manage PGP keys
      programs.gpg.enable = true;

      # Extra packages, not handled by home-manager
      home.packages = with pkgs; [
        # Utilities
        clang # Modern C/C++ compiler
        xclip # CLI clipboard manager
        fd # Find files and directories
        ripgrep # Search content of files
        ranger # Explore directories and files in the terminal
        grex # Get regex from results
        slides # Slideshow in the terminal using Markdown
        glow # Render Markdown in the CLI
        xxd # Hex dumper
        usbutils # lsusb and other utilities
        jq # Command-line JSON processor
        dua # Disk usage analyser CLI
        evince # PDF viewer part of the GNOME project
        gcr # Provides org.gnome.keyring.SystemPrompter
        gh # GitHub CLI tool

        # Nix tools
        nixpkgs-fmt # Format Nix files the nixpkgs' way

        # Applications
        vlc # VLC media player
        spotify # Proprietary music streaming
        gimp # Edit photos for freeeeeee
        anki-bin # Free spaced repetition learning tool
        godot_4 # Create games for freeeeeee
        obs-studio # Video/Screen recording and streaming app
        ledger-live-desktop # Desktop app to control and update Ledger Nano X HW wallet
        inkscape # Vector graphics for freeeeeee
        mpv # Media player
        mission-center # A Windows-themed process monitoring GUI
        aseprite # Pixel art drawing software
        loupe # GNOME image viewer
      ]
      ++ lib.lists.optionals isDconfEnabled [
        dconf-editor # GUI for editing dconf entries
        dconf2nix # Convert dconf files to Nix files
      ]
      ++ lib.lists.optionals isBootloaderLanzaboote [
        sbctl # Secure Boot key manager
      ]
      ;
    };
}
