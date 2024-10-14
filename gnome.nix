# The general Gnome utilities, plugins, and settings for both NixOS and non-NixOS systems.
{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnome-extension-manager # Find, install, and manager gnome extensions
    gnome-tweaks # Extra settings for tweaking gnome
  ];

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = tray-icons-reloaded; } # Show notification icons in the system tray/bar
      { package = system-monitor; } # Show system stats in the system tray/bar
      { package = freon; } # System stats such as temps
    ];
  };
}
