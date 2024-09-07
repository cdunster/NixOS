{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    plugins = [
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
          set _selected (fzf --multi --preview="bat {1} --color=always" --header="Open in nvim:")
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
      _open_neovim = {
        body = ''
          if test -e Session.vim
              nvim -S Session.vim
          else if test -e ../Session.vim
              nvim -S ../Session.vim
          else
            read -n 1 -l -P 'No Session.vim found, create one? [Y/n] ' _answer
            commandline --function repaint

            switch $_answer
                case "" Y y
                    nvim -c Obsession
            end
          end
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
      bind \cn _open_neovim
    '';
    interactiveShellInit = ''
      if not set -q TMUX; exec tmux; end
    '';
  };
}
