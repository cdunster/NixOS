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
    spotify
    slack
    nixgl.nixGLIntel
    fira-code
    grex
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
    functions = {
      _fzf_open_file_nvim = {
        body = ''
          set _selected (fzf-tmux -p --multi --inline-info --reverse --height=30 --preview="_fzf_preview_file {}" --header="Open in nvim:" --header-first)
          if test -n "$_selected"
              nvim $_selected
          end

          commandline --function repaint
        '';
      };
    };
    shellInit = ''
      set -g fish_greeting ""

      bind \cf "_fzf_open_file_nvim"
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
  programs.brave.enable = true;
}
