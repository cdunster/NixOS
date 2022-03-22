# Manage user accounts with home-manager.
{ config, pkgs, ... }: {
  imports = [
    ./dconf.nix
    ./fish.nix
    ./neovim.nix
    ./git.nix
    ./tmux.nix
  ];

  # Let home-manager manage its own installation.
  programs.home-manager.enable = true;

  # Add the background image.
  home.file.".local/share/backgrounds/mr_robot.jpg".source = ./images/mr_robot.jpg;

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
    clang_12
    nodePackages.pyright
    sumneko-lua-language-server
    nixpkgs-fmt
  ];

  home.sessionVariables = {
    FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
    FZF_DEFAULT_OPTS = "--inline-info --reverse --height=30 --header-first";
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

  programs.bat.enable = true;
  programs.exa.enable = true;
  programs.fzf.enable = true;
  programs.direnv.enable = true;
  programs.brave.enable = true;
}
