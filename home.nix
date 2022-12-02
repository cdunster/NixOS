# Manage user accounts with home-manager.
{ config, pkgs, ... }: {
  imports = [
    ./dconf.nix
    ./fish.nix
    ./starship.nix
    ./neovim.nix
    ./git.nix
    ./tmux.nix
    ./taskwarrior.nix
    ./nushell.nix
    ./zellij.nix
  ];

  # Let home-manager manage its own installation.
  programs.home-manager.enable = true;

  # Add the background image.
  home.file.".local/share/backgrounds/mr_robot.jpg".source = ./images/mr_robot.jpg;

  # The version of Home-manager used.
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    # Nice WM for non-Pop!_OS systems:
    # gnomeExtensions.material-shell

    # Utilities
    xclip # CLI clipboard manager
    fd # Find files and directories
    ripgrep # Search content of files
    grex # Get regex from results
    rargs # Batch CLI stuff (xargs + awk)
    gnomeExtensions.emoji-selector # Select emojis with nice gnome UI
    gnome.gnome-tweaks # Extra settings for tweaking gnome
    slides # Slideshow in the terminal using Markdown

    # Fonts
    (nerdfonts.override { fonts = [ "Hack" ]; })

    # Nix tools
    dconf2nix # Convert dconf files to Nix files
    nixgl.nixGLIntel # OpenGL wrapper: needed for running some applications
    nixpkgs-fmt # Format Nix files the nixpkgs' way

    # Applications
    spotify # Proprietary music streaming

    # LSPs
    clang-tools # C/C++
    nodePackages.pyright # Python
    sumneko-lua-language-server # Lua
    nodePackages.vscode-css-languageserver-bin # CSS
    rust-analyzer # Rust
    rnix-lsp # Nix
    buf-language-server # Protobuf

    # Work
    teams # Microsoft Teams - Proprietary IM.
    lazydocker # Manage docker stuff the lazy way.
    awscli2 # Manage AWS from the command line.
    vscode # Proprietary code/text editor from Microsoft.
  ];

  fonts.fontconfig.enable = true;

  programs.kitty = {
    enable = true;
    package = pkgs.writeShellScriptBin "kitty" ''
      ${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${pkgs.kitty}/bin/kitty ${pkgs.zellij}/bin/zellij
    '';
    theme = "Dracula";
    settings = {
      font_size = "14.0";
      font_family = "Hack Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
    };
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
  programs.exa.enable = true;
  programs.brave.enable = true;
  programs.zoxide.enable = true;

  services.dropbox.enable = true;
}
