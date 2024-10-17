# Gnome packages and settings for NixOS systems.
{ pkgs, ... }: {
  imports = [
    ./gnome.nix # The general Gnome packages for all systems.
  ];

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = pop-shell; } # The GNOME Shell used in Pop!_OS.
    ];
  };
}
