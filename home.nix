# Manage user accounts with home-manager.
{ config, pkgs, ... }: {
  imports = [
    ./dconf.nix
    ./kitty.nix
    ./fish.nix
    ./starship.nix
    ./neovim.nix
    ./git.nix
    ./tmux.nix
  ];

  # Let home-manager manage its own installation.
  programs.home-manager.enable = true;

  # Add the background image.
  home.file.".local/share/backgrounds/".source = ./images/backgrounds;

  # The version of Home-manager used.
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    # Gnome
    gnome-extension-manager # Find, install, and manager gnome extensions
    dracula-theme # Dracula theme for the gnome shell
    gnome.gnome-tweaks # Extra settings for tweaking gnome

    # Utilities
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
    grcov # Code coverage report generator
    xxd # Hex dumper

    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    cdunster.wps-fonts

    # Nix tools
    dconf2nix # Convert dconf files to Nix files
    nixpkgs-fmt # Format Nix files the nixpkgs' way

    # Applications
    spotify # Proprietary music streaming
    gimp # Edit photos for freeeeeee
    freecad # 3D CAD software for freeeeeee
    anki-bin # Free spaced repetition learning tool
    godot_4 # Create games for freeeeeee
    wpsoffice # A free office suit

    # LSPs
    clang-tools # C/C++
    nodePackages.pyright # Python
    lua-language-server # Lua
    nodePackages.vscode-css-languageserver-bin # CSS
    rust-analyzer # Rust
    nixd # Nix
    buf-language-server # Protobuf

    # Work
    teams-for-linux # Unofficial Linux wrapper for Microsoft Teams PWA.
    slack # Linux Slack messaging app
    lazydocker # Manage docker stuff the lazy way.
    awscli2 # Manage AWS from the command line.
    vscode # Proprietary code/text editor from Microsoft.
    bloomrpc # GUI client for gRPC (like postman for gRPC)
    sqlitebrowser # A database browser for SQLite
    saleae-logic-2 # Logic analyser
    balena-cli # Manage Balena through a CLI
    awscli2 # Manage AWS instances through a CLI
  ];

  fonts.fontconfig.enable = true;

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
  programs.brave.enable = true;
  programs.zoxide.enable = true;
  programs.gpg.enable = true;
}
