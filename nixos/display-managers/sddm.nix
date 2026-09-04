{ pkgs, lib, config, ... }:
let
  cfg = config.hostOptions.displayManagers;
in
lib.mkIf (cfg.displayManager == "sddm") {
  # Use the Simple Desktop Display Manager (SDDM)
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm; # Use Qt6 version of SDDM for catppuccin support
    wayland.enable = cfg.enableWayland;
  };
}
