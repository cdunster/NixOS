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
      pointerCursor = {
        enable = true;
        accent = "dark";
      };
    };

    # GTK system theme
    gtk = {
      enable = true;
      catppuccin = {
        enable = true;
        gnomeShellTheme = cfg.desktopEnvironments.gnome.enable;
      };
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };
}
