{ inputs, config, ... }:
let
  cfg = config.hostOptions;
in
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  # System theme
  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "blue";
  };

  home-manager.users.${cfg.user} = {
    imports = [
      inputs.catppuccin.homeModules.catppuccin
    ];

    # System theme
    catppuccin = {
      inherit (config.catppuccin) enable flavor accent;
      cursors = {
        inherit (config.catppuccin) enable;
        accent = "dark";
      };
      gtk = {
        inherit (config.catppuccin) enable;
      };
      tmux.extraConfig = ''
        set -g @catppuccin_status_modules_left "session directory"
        set -g @catppuccin_status_modules_right "cpu date_time"

        set -g @catppuccin_window_status "icon"
        set -g @catppuccin_icon_window_last ""
        set -g @catppuccin_icon_window_current ""
        set -g @catppuccin_window_left_separator " "
        set -g @catppuccin_window_middle_separator " | "
        set -g @catppuccin_window_right_separator ""
        set -g @catppuccin_window_default_text "#W"
        set -g @catppuccin_window_current_text "#W"

        set -g @catppuccin_window_default_fill "none"
        set -g @catppuccin_window_current_fill "all"
        set -g @catppuccin_window_current_color "#{thm_blue}"
        set -g @catppuccin_status_justify "absolute-centre"

        set -g @catppuccin_directory_icon "󰉖"
        set -g @catppuccin_session_icon ""

        set -g @catppuccin_status_left_separator " "
        set -g @catppuccin_status_right_separator ""
        set -g @catppuccin_status_connect_separator "no"

        set -g @catppuccin_status_background "#{thm_black}"
      '';
    };
  };
}
