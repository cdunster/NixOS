{ inputs, config, ... }:
let
  cfg = config.hostOptions;
in
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  home-manager.users.${cfg.user} = {
    imports = [
      inputs.catppuccin.homeManagerModules.catppuccin
    ];

    # System theme
    catppuccin = {
      enable = true;
      flavor = "frappe";
      accent = "blue";
      pointerCursor = {
        enable = true;
        flavor = "frappe";
        accent = "dark";
      };
    };

    # GTK system theme
    gtk = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "frappe";
        accent = "blue";
        icon = {
          enable = true;
          flavor = "frappe";
          accent = "blue";
        };
        gnomeShellTheme = cfg.desktopEnvironment.gnome.enable;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    # Qt system theme
    qt.style.catppuccin = {
      enable = true;
      flavor = "frappe";
      accent = "blue";
    };

  };
}
