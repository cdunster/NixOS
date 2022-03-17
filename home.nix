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
          set _selected (fzf-tmux -p --multi --preview="_fzf_preview_file {}" --header="Open in nvim:")
          if test -n "$_selected"
              nvim $_selected
          end

          commandline --function repaint
        '';
      };
      _fzf_start_tmuxinator = {
        body = ''
          set _projects (tmuxinator list --newline)
          set _result (printf '%s\n' $_projects | fzf-tmux -p --header-lines=1 --print-query)
          set _query $_result[1]
          set _selected $_result[2]

          if contains "$_selected" $_projects
              tmuxinator start $_selected
          else if test -n "$_query"
              tmuxinator new $_query
          end

          commandline --function repaint
        '';
      };
    };
    shellInit = ''
      set -g fish_greeting ""

      bind \cf "_fzf_open_file_nvim"
      bind \cp "_fzf_start_tmuxinator"
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
