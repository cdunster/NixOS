# Manage user accounts with home-manager.
{ config, pkgs, ... }: {
  imports = [
    ./dconf.nix
    ./neovim.nix
    ./git.nix
    ./tmux.nix
  ];

  # Let home-manager manage its own installation.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Nice WM for non-Pop!_OS systems: gnomeExtensions.material-shell
    dconf2nix
    fd
    ripgrep
    brave
    spotify
    slack
    nixgl.nixGLIntel
    fira-code
  ];

  home.sessionVariables.FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";

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

  programs.fish = {
    enable = true;
    shellAliases = {
      lg = "lazygit";
      ll = "exa -lah";
    };
    shellAbbrs = {
      d = "pushd";
      ".." = "popd";
    };
    shellInit = ''
      set -g fish_greeting ""
    '';
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

  programs.bottom.enable = true;
  programs.bat.enable = true;
  programs.exa.enable = true;
  programs.fzf.enable = true;
  programs.direnv.enable = true;
}
