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

  home.sessionVariables.SHELL = "${pkgs.nushell}";

  home.packages = with pkgs; [
    # Nice WM for non-Pop!_OS systems:
    # gnomeExtensions.material-shell

    # Utilities
    xclip                           # CLI clipboard manager
    fd                              # Find files and directories
    ripgrep                         # Search content of files
    grex                            # Get regex from results
    gnomeExtensions.emoji-selector  # Select emojis with nice gnome UI
    gnome.gnome-tweaks              # Extra settings for tweaking gnome

    # Fonts
    (nerdfonts.override { fonts = [ "Hack" ]; })

    # Nix tools
    dconf2nix         # Convert dconf files to Nix files
    nixgl.nixGLIntel  # OpenGL wrapper: needed for running some applications
    nixpkgs-fmt       # Format Nix files the nixpkgs' way

    # Applications
    spotify   # Proprietary music streaming

    # LSPs
    clang-tools                                 # C/C++
    nodePackages.pyright                        # Python
    sumneko-lua-language-server                 # Lua
    nodePackages.vscode-css-languageserver-bin  # CSS
    rust-analyzer                               # Rust

    # Work Tools
    stm32cubemx   # CubeMX tool for STM32 uCs
    slack         # Proprietary IM tool
  ];

  fonts.fontconfig.enable = true;

  xdg.desktopEntries = {
    stm32cubemx = {
      name = "STM32CubeMX";
      exec = "stm32cubemx";
      terminal = false;
      categories = [ "Application" ];
    };
  };

  programs.kitty = {
    enable = true;
    package = pkgs.writeShellScriptBin "kitty" ''
      ${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${pkgs.kitty}/bin/kitty "$@"
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
}
