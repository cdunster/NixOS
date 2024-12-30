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

    catppuccin = {
      # Inherit system theme from NixOS module
      inherit (config.catppuccin) enable flavor accent;

      cursors = {
        enable = true;
        accent = "dark";
      };

      gtk = {
        enable = true;
        icon.enable = true;
        gnomeShellTheme = cfg.desktopEnvironments.gnome.enable;
      };
    };

    # GTK system theme
    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };
}
