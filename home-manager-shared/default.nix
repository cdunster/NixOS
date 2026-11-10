{ pkgs, lib, osConfig, config, ... }: {
  imports = [
    ./cosmic-de
    ./git.nix
    ./niri-compositor.nix
    ./style.nix
    ./shells
    ./terminals
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

      # Set Brave as the default browser
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "x-scheme-handler/http" = "brave-browser.desktop";
          "x-scheme-handler/https" = "brave-browser.desktop";
        };
      };

      # Manage standard user directories (Desktop, Documents, Downloads, etc.)
      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = true;
      };

      # Command-line fuzzy-finding tool
      programs.fzf = {
        enable = true;
        defaultCommand = "fd --type=f --hidden --exclude=.git";
        defaultOptions = [
          "--inline-info"
          "--reverse"
          "--height=30"
          "--header-first"
        ];
      };

      # A very nice TUI for managing git repos
      programs.lazygit = {
        enable = true;
        settings = {
          notARepository = "skip";
          gui.showCommandLog = false;
          gui.theme.selectedLineBgColor = [ "#${config.lib.stylix.colors.base02}" ];
          git.overrideGpg = true;
        };
      };

      # Enable lazydocker TUI to manager docker if docker itself is enabled
      programs.lazydocker.enable = isDockerEnabled;

      # Enable GNU Privacy Guard to manage PGP keys
      programs.gpg.enable = true;

      # Extra packages, not handled by home-manager
      home.packages = with pkgs; [
        # Utilities
        clang # Modern C/C++ compiler
        wl-clipboard # CLI clipboard manager for Wayland
        xdg-utils # Commands for launching user default programs
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
        gcr_4 # Provides a prompter for GNOME keyrings
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
        nautilus # GNOME file browser
      ]
      ++ lib.lists.optionals isDconfEnabled [
        dconf-editor # GUI for editing dconf entries
        dconf2nix # Convert dconf files to Nix files
      ]
      ++ lib.lists.optionals isBootloaderLanzaboote [
        sbctl # Secure Boot key manager
      ];
    };
}
