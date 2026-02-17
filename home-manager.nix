# This is actually the NixOS module used to enable and setup home-manager
{ inputs, pkgs, config, ... }:
let
  user = config.hostOptions.user;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
  };

  home-manager.users.${user} = {
    # Let home-manager manage its own installation.
    programs.home-manager.enable = true;

    # Add user profile picture.
    home.file.".face".source = ./images/backgrounds/deer_sunset.jpg;

    # The version of Home-manager used.
    home.stateVersion = "22.11";

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
      neohtop # A modern system monitor GUI
      aseprite # Pixel art drawing software
      imv # Image view for X11 and Wayland
    ];
  };
}
