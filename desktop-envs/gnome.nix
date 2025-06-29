{ pkgs, lib, config, ... }: {
  options.hostOptions.desktopEnvironments.gnome = with lib; {
    enable = mkEnableOption "Enable the GNOME desktop environment";
  };

  config =
    let
      cfg = config.hostOptions.desktopEnvironments.gnome;
    in
    lib.mkIf cfg.enable {
      # Enable managing dconf with NixOS and home-manager modules
      programs.dconf.enable = true;

      services = {
        # Use the GNOME Desktop Environment
        desktopManager.gnome.enable = true;

        xserver = {
          # Enable the X11 display server
          enable = true;

          # Configure the X11 keyboard layout
          xkb = {
            layout = "us";
            variant = "euro";
            options = "caps:none";
          };
        };
      };

      # Exclude these packages from the GNOME install
      environment.gnome.excludePackages = (with pkgs; [
        gnome-tour
        gnome-connections
        gnome-console # GNOME terminal emulator
        gedit # text editor
        epiphany # web browser
        gnome-terminal
        gnome-music
        gnome-characters
        gnome-contacts
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        gnome-weather
      ]);

      home-manager.users.${config.hostOptions.user} = {
        home.packages = with pkgs; [
          gnome-tweaks # Extra settings for tweaking gnome
        ];

        programs.gnome-shell = {
          enable = true;
          extensions = with pkgs.gnomeExtensions; [
            { package = pop-shell; } # The GNOME Shell extension used in Pop!_OS for tiling WM
            { package = tray-icons-reloaded; } # Show notification icons in the system tray/bar
            { package = system-monitor; } # Show system stats in the system tray/bar
            { package = freon; } # System stats such as temps
            { package = auto-move-windows; } # Automatically move apps to a workspace when launched
          ];
        };
      };
    };
}

