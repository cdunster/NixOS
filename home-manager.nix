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
      rargs # Batch CLI stuff (xargs + awk)
      slides # Slideshow in the terminal using Markdown
      glow # Render Markdown in the CLI
      xxd # Hex dumper
      usbutils # lsusb and other utilities

      # Nix tools
      nixpkgs-fmt # Format Nix files the nixpkgs' way

      # Applications
      vlc # VLC media player
      spotify # Proprietary music streaming
      gimp # Edit photos for freeeeeee
      anki-bin # Free spaced repetition learning tool
      godot_4 # Create games for freeeeeee
      wpsoffice # A free office suit
      obs-studio # Video/Screen recording and streaming app
      ledger-live-desktop # Desktop app to control and update Ledger Nano X HW wallet
      inkscape # Vector graphics for freeeeeee

      # LSPs
      clang-tools # C/C++
      pyright # Python
      lua-language-server # Lua
      vscode-langservers-extracted # HTML/CSS/JSON/ESLint
      rust-analyzer # Rust
      nixd # Nix

      # DAPs Debuggers
      lldb # The debugger for the LLVM Project (lldb-dap)
      llvm # Compiler tools for the LLVM Project (llvm-symbolizer)
    ];
  };
}
