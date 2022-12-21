{ config, pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      lg = "lazygit";
      ll = "exa -lah";
      ls = "exa";
      cd = "z";
    };
    plugins = [
      {
        name = "dracula-fish";
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "fish";
          rev = "master";
          sha256 = "WywEGAGaRwfHJpT+B3oKoyrnLJZxURTQ+MK9e5Asxl0=";
        };
      }
      {
        # Completions for direnv (and others).
        name = "fish-completions";
        src = pkgs.fetchFromGitHub {
          owner = "etcusrvar";
          repo = "fish-completions";
          rev = "master";
          sha256 = "ouqtaf22Wji57yULCxxTiisW7zkKRPOeZSkhdPQ+i1o=";
        };
      }
    ];
    functions = {
      _fzf_open_file_nvim = {
        body = ''
          set _selected (fzf --multi --preview="_fzf_preview_file {}" --header="Open in nvim:")
          if test -n "$_selected"
              nvim $_selected
          end

          commandline --function repaint
        '';
      };
      _fzf_live_grep = {
        body = ''
          set _rg_cmd "rg --column --line-number --no-heading --color=always --smart-case"
          set _query (commandline --current-token)
          set _fzf (FZF_DEFAULT_COMMAND="$_rg_cmd '$_query'" \
              fzf \
              --ansi \
              --disabled \
              --query $_query \
              --bind "change:reload:sleep 0.1; $_rg_cmd {q} || true" \
              --delimiter : \
              --preview 'bat {1} --color=always --highlight-line {2}' \
              --preview-window '+{2}+3/3,~3')
          set _fzf (string split : $_fzf)

          commandline --function repaint
          commandline --replace ""

          if test -n "$_fzf[1]"
              nvim +$_fzf[2] $_fzf[1]
          end
        '';
      };
      _zoxide_zi = {
        body = ''
          zi

          commandline --function repaint
          commandline --replace ""
        '';
      };
      lf = {
        description = "If file; print content to stdout, else list directory.";
        argumentNames = "path";
        body = ''
          if test -z $path
            ll .
          else if test -f $path
            bat $path
          else if test -d $path
            ll $path
          end
        '';
      };
    };
    shellInit = ''
      set -g fish_greeting ""

      bind \cf _fzf_open_file_nvim
      bind \cg _fzf_live_grep
      bind \cp _zoxide_zi
    '';
    interactiveShellInit = ''
      if not set -q ZELLIJ; exec zellij; end
    '';
  };

  home.sessionVariables.SHELL = "${config.home.homeDirectory}/.nix-profile/bin/fish";
}
