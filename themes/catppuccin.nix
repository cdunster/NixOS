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
      inputs.catppuccin.homeManagerModules.catppuccin
    ];

    # System theme
    catppuccin = {
      inherit (config.catppuccin) enable flavor accent;
      cursors = {
        enable = true;
        accent = "dark";
      };
      gtk = {
        enable = true;
        gnomeShellTheme = cfg.desktopEnvironments.gnome.enable;
      };
    };
  };
}
