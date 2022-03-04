{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    baseIndex = 1;
    escapeTime = 20;
    terminal = "screen-256color";
    tmuxinator.enable = true;
    extraConfig = ''
      bind v split-window -v
      bind h split-window -h

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind -r C-h resize-pane -L
      bind -r C-j resize-pane -D
      bind -r C-k resize-pane -U
      bind -r C-l resize-pane -R
    '';
    plugins = with pkgs.tmuxPlugins; [
      { plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      { plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10' # minutes
        '';
      }
    ];
  };

  # Source tmuxinator project definition files.
  xdg.configFile.tmuxinator.source = ./tmuxinator;
}
