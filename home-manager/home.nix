# Manage user accounts with home-manager.
{ pkgs, config, ... }:
let
  cfg = config.hostOptions;
in
{
  imports = [
    ./dconf.nix
    ./kitty.nix
    ./starship.nix
    ./git.nix
    ./tmux.nix
    ./wezterm
  ];

  # Let home-manager manage its own installation.
  programs.home-manager.enable = true;

  # Add the background image.
  home.file.".local/share/backgrounds/".source = ./images/backgrounds;

  # Add user profile picture.
  home.file.".face".source = ./images/backgrounds/deer_sunset.jpg;

  # The version of Home-manager used.
  home.stateVersion = "22.11";

  # System theme
  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "blue";
    pointerCursor = {
      enable = true;
      flavor = "frappe";
      accent = "dark";
    };
  };

  # GTK system theme
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "frappe";
      accent = "blue";
      icon = {
        enable = true;
        flavor = "frappe";
        accent = "blue";
      };
      gnomeShellTheme = cfg.desktopEnvironment.gnome.enable;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Qt system theme
  qt.style.catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "blue";
  };

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
    zoom-us # Video conferencing software
    dconf-editor # GUI for editing dconf entries

    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    cdunster.ttf-wps-fonts

    # Nix tools
    dconf2nix # Convert dconf files to Nix files
    nixpkgs-fmt # Format Nix files the nixpkgs' way

    # Applications
    spotify # Proprietary music streaming
    gimp # Edit photos for freeeeeee
    anki-bin # Free spaced repetition learning tool
    godot_4 # Create games for freeeeeee
    wpsoffice # A free office suit
    obs-studio # Video/Screen recording and streaming app
    discord # Chat desktop app for gamers and communities
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

    # Work
    mattermost-desktop # Desktop client Mattermost; a collaboration and chat app for businesses
  ]
  # Install `sbctl`, a Secure Boot key manager if lanzaboote is enabled
  ++ lib.optional (cfg.bootloader == "lanzaboote") pkgs.sbctl;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "JetBrainsMono Nerd Font 10" ];
      monospace = [ "JetBrainsMono Nerd Font Mono 11" ];
    };
  };

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
  programs.brave.enable = true;
  programs.zoxide.enable = true;
  programs.gpg.enable = true;
}
