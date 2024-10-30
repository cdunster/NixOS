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

    # Add the background image.
    home.file.".local/share/backgrounds/".source = ./images/backgrounds;

    # Add user profile picture.
    home.file.".face".source = ./images/backgrounds/deer_sunset.jpg;

    # The version of Home-manager used.
    home.stateVersion = "22.11";

    # Increase the cursor size to match Brave browser cursor
    home.pointerCursor.size = 40;

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
      asciidoctor-with-extensions # Convert asciidoc files into other formats
      pandoc # Powerful document conversion tool
      plantuml # Create UML diagrams with a markup language
      nodePackages.mermaid-cli # Create nicer looking diagrams with a markup language
      xxd # Hex dumper
      usbutils # lsusb and other utilities
      vlc # VLC media player

      # Nix tools
      nixpkgs-fmt # Format Nix files the nixpkgs' way

      # Applications
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
      buf-language-server # Protobuf

      # DAPs Debuggers
      lldb # The debugger for the LLVM Project (lldb-dap)
      llvm # Compiler tools for the LLVM Project (llvm-symbolizer)
    ];

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb
      ];
    };

    programs.lazygit = {
      enable = true;
      settings = {
        notARepository = "skip";
        gui = {
          showCommandLog = false;
        };
      };
    };

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

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.bat.enable = true;
    programs.eza.enable = true;
    programs.zoxide.enable = true;
    programs.gpg.enable = true;
  };
}
