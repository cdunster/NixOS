{ lib, osConfig, config, ... }:
let
  isZellijEnabled = config.programs.zellij.enable;
  isDuxShellEnabled = osConfig.programs.dux-shell.enable;
in
{
  programs.kitty = {
    enable = true;
    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      hide_window_decorations = "yes";
    };
    keybindings = {
      "ctrl+tab" = "send_key ctrl+tab";
      "ctrl+shift+tab" = "send_key ctrl+shift+tab";
      "alt+c" = "send_key alt+c";
      "alt+shift+c" = "send_key alt+shift+c";
      "alt+9" = "send_key alt+9";
      "alt+shift+9" = "send_key alt+shift+9";
      "alt+0" = "send_key alt+0";
      "alt+shift+0" = "send_key alt+shift+0";
    };
    extraConfig = lib.mkAfter ''
      ${lib.optionalString isZellijEnabled "startup_session launch.conf"}

      ${lib.optionalString isDuxShellEnabled ''
        # Dux generates these files with Matugen
        include dank-theme.conf
        include dank-tabs.conf
      ''}
    '';
  };

  xdg.configFile."kitty/launch.conf".text = lib.mkIf isZellijEnabled ''launch sh -c "zellij -l welcome"'';
}
