{ lib, osConfig, ... }:
let
  isDuxShellEnabled = osConfig.programs.dux-shell.enable;
in
{
  config = {
    # Dux uses Matugen to set the colours of these targets instead of Stylix
    stylix.targets = lib.mkIf isDuxShellEnabled {
      gtk.colors.enable = false;
      qt.colors.enable = false;
      kitty.colors.enable = false;
      neovim.colors.enable = false;
      zellij.colors.enable = false;
      starship.colors.enable = false;
      lazygit.colors.enable = false;
    };
  };
}
