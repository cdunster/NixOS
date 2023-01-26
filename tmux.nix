{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    baseIndex = 1;
    escapeTime = 20;
    terminal = "screen-256color";
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

      bind v split-window -v -l 30% -c "#{pane_current_path}"
      bind h split-window -h -c "#{pane_current_path}"

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
    "tmuxinator/home-manager.yml".source = ./tmuxinator/home-manager.yml;
  };
}
