{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    baseIndex = 1;
    escapeTime = 20;
    terminal = "screen-256color";
    tmuxinator.enable = true;
    prefix = "C-Space";
    extraConfig = ''
      set -g mouse on

      bind v split-window -v -l 30%
      bind h split-window -h

      bind n new-session

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind -n M-] select-window -n
      bind -n M-[ select-window -p

      bind -r C-h resize-pane -L
      bind -r C-j resize-pane -D
      bind -r C-k resize-pane -U
      bind -r C-l resize-pane -R
    '';
  };

  # Source tmuxinator project definition files.
  xdg.configFile = {
    "tmuxinator/PinOS.yml".source = ./tmuxinator/PinOS.yml;
    "tmuxinator/g5plus.yml".source = ./tmuxinator/g5plus.yml;
    "tmuxinator/race.yml".source = ./tmuxinator/race.yml;
    "tmuxinator/home-manager.yml".source = ./tmuxinator/home-manager.yml;
    "tmuxinator/triplab.yml".source = ./tmuxinator/triplab.yml;
    "tmuxinator/HMI.yml".source = ./tmuxinator/HMI.yml;
  };
}
