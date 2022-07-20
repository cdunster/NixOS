# Manage user accounts with home-manager.
{ config, pkgs, ... }: {
  imports = [
    ./dconf.nix
    ./fish.nix
    ./neovim.nix
    ./git.nix
    ./tmux.nix
    ./taskwarrior.nix
  ];

  # Let home-manager manage its own installation.
  programs.home-manager.enable = true;

  # Add the background image.
  home.file.".local/share/backgrounds/mr_robot.jpg".source = ./images/mr_robot.jpg;

  # The version of Home-manager used.
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    # Nice WM for non-Pop!_OS systems: gnomeExtensions.material-shell
    dconf2nix
    fd
    ripgrep
    spotify
    slack
    nixgl.nixGLIntel
    fira-code
    grex
    clang-tools
    nodePackages.pyright
    sumneko-lua-language-server
    nixpkgs-fmt
    nodePackages.vscode-css-languageserver-bin
    rust-analyzer
    stm32cubemx
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
    theme = "Tokyo Night Storm";
    font = {
      name = "Fira Code";
      size = 14;
    };
  };

  programs.starship.enable = true;

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
