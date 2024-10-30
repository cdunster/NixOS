{ pkgs, lib, config, ... }: {
  options.hostOptions.displayManagers.sddm = with lib; {
    enable = mkEnableOption "Enable the Simple Desktop Display Manager";
    wayland = mkEnableOption "Use Wayland as the display protocol instead of X11";
  };

  config =
    let
      cfg = config.hostOptions.displayManagers.sddm;
    in
    lib.mkIf cfg.enable {
      # Use the Simple Desktop Display Manager (SDDM)
      services.displayManager.sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm; # Use Qt6 version of SDDM for catppuccin support
        wayland.enable = cfg.wayland;
      };
    };
}
