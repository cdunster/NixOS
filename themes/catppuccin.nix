{ inputs, lib, config, ... }:
let
  user = config.hostOptions.user;
  tmuxEnabled = config.hostOptions.tmux.enable;
  cfg = config.hostOptions.themes.catppuccin;
in
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  options.hostOptions.themes.catppuccin = with lib; {
    enable = mkEnableOption "Enable the catppuccin theme system-wide";
  };

  config = {
    # System theme
    catppuccin = {
      enable = cfg.enable;
      autoEnable = cfg.enable;
      flavor = "frappe";
      accent = "blue";
    };

    home-manager.users.${user} = {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
      ];

      # System theme
      catppuccin = {
        inherit (config.catppuccin) enable autoEnable flavor accent;
        cursors.accent = "dark";
        tmux.extraConfig = lib.mkIf (cfg.enable && tmuxEnabled) ''
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
  };
}
