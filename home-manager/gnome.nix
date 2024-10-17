# GNOME utilities, plugins, and settings
{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnome-extension-manager # Find, install, and manager gnome extensions
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
}
