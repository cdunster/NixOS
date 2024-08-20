{ pkgs, ... }: {

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    baseIndex = 1;
    escapeTime = 20;
    terminal = "tmux-256color";
    prefix = "M-Space";
    plugins = with pkgs.tmuxPlugins; [
      cpu
    ];
    catppuccin.extraConfig = ''
      set -g @catppuccin_status_modules_right "session directory cpu date_time"

      set -g @catppuccin_window_status_enable "yes"
      set -g @catppuccin_icon_window_last ""
      set -g @catppuccin_icon_window_current ""
      set -g @catppuccin_window_separator ""
      set -g @catppuccin_window_left_separator " "
      set -g @catppuccin_window_middle_separator "▌"
      set -g @catppuccin_window_right_separator ""
      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_current_text "#W"

      set -g @catppuccin_directory_icon "󰉖"
      set -g @catppuccin_session_icon ""

      set -g @catppuccin_status_left_separator " "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_connect_separator "no"

      set -g @catppuccin_status_background "#{thm_black}"
    '';
    extraConfig = ''
      set -g mouse on
      set -sa terminal-features ',xterm-kitty:RGB'

      unbind -T copy-mode-vi MouseDragEnd1Pane

      bind v split-window -v -l 30% -c "#{pane_current_path}"
      bind h split-window -h -c "#{pane_current_path}"

      bind M-p split-pane -c "#{pane_current_path}"

      bind t switch-client -Ttab
      bind -Ttab g new-window -n lazygit -c "#{pane_current_path}" lazygit

      bind -n M-g new-window -n lazygit -c "#{pane_current_path}" lazygit
      bind -n M-s split-window -h -c "#{pane_current_path}"
      bind -n M-v split-window -v -l 30% -c "#{pane_current_path}"

      bind M-t new-window -c "#{pane_current_path}"

      bind M-n new-session

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
}
