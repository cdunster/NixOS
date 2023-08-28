{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    baseIndex = 1;
    escapeTime = 20;
    terminal = "tmux-256color";
    tmuxinator.enable = true;
    prefix = "M-Space";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = dracula;
        extraConfig = ''
          # Available plugins: battery, cpu-usage, git, gpu-usage, ram-usage, network, network-bandwidth, network-ping, weather, time
          set -g @dracula-plugins "cpu-usage ram-usage"

          set -g @dracula-show-powerline true
          set -g @dracula-show-left-icon session
          set -g @dracula-show-flags true
          set -g @dracula-left-icon-padding 0

        '';
      }
    ];
    extraConfig = ''
      set -g mouse on

      unbind -T copy-mode-vi MouseDragEnd1Pane

      bind v split-window -v -l 30% -c "#{pane_current_path}"
      bind h split-window -h -c "#{pane_current_path}"

      bind M-p split-pane -c "#{pane_current_path}"

      bind t switch-client -Ttab
      bind -Ttab g new-window -n lazygit -c "#{pane_current_path}" lazygit

      bind M-t new-window -c "#{pane_current_path}"

      bind M-s new-session

      bind M-w popup -E -h 90% -w 90% nvim -c "cd ~/wiki" -c WikiJournal

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind -n M-Left select-pane -L
      bind -n M-Down select-pane -D
      bind -n M-Up select-pane -U
      bind -n M-Right select-pane -R

      bind -n M-] select-window -n
      bind -n M-[ select-window -p

      bind -n M-H resize-pane -L
      bind -n M-J resize-pane -D
      bind -n M-K resize-pane -U
      bind -n M-L resize-pane -R

      bind -n M-S-Left resize-pane -L
      bind -n M-S-Down resize-pane -D
      bind -n M-S-Up resize-pane -U
      bind -n M-S-Right resize-pane -R
    '';
  };

  # Source tmuxinator project definition files.
  xdg.configFile = {
    "tmuxinator/home-manager.yml".source = ./tmuxinator/home-manager.yml;
  };
}
