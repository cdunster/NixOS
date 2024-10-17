{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    plugins = [
      {
        name = "zsh-cargo-completion";
        src = pkgs.fetchFromGitHub {
          owner = "MenkeTechnologies";
          repo = "zsh-cargo-completion";
          rev = "3430f33b7d446ee6d89ce16ed5eedf387b4c1a17";
          sha256 = "sha256-407P02jqvIshdrbOAKkNFsIFjUlEkGpNYzG79CB7Qyw=";
        };
      }
    ];
    initExtra = ''
      _zoxide_zi() zi
      zle -N _zoxide_zi
      bindkey '^P' _zoxide_zi

      _open_neovim() {
          if [ -f Session.vim ]; then
              nvim -S Session.vim
          elif [ -f ../Session.vim ]; then
              nvim -S ../Session.vim
          elif read -q '_answer?No Session.vim found, create one? [y/N]'; then
              zle reset-prompt
              nvim -c Obsession
          else
              zle reset-prompt
          fi
      }
      zle -N _open_neovim
      bindkey '^N' _open_neovim

      lf() {
          if [ -z "$1" ]; then
            eza -lah .
          elif [ -f "$1" ]; then
            bat $1
          elif [ -d "$1" ]; then
            eza -lah $1
          fi
      }

      # Fix the keyboard delete key binding
      bindkey '^[[3~' delete-char
      # Fix the keyboard shift-delete key binding
      bindkey '^[[3;2~' delete-char

      # Fix the keyboard home key binding
      bindkey '^[[1~' beginning-of-line
      # Fix the keyboard shift-home key binding
      bindkey '^[[1;2H' beginning-of-line

      # Fix the keyboard end key binding
      bindkey '^[[4~' end-of-line
      # Fix the keyboard shift-end key binding
      bindkey '^[[1;2F' end-of-line

      if (( ''${+TMUX} )); then tmux; fi
    '';
  };
}
