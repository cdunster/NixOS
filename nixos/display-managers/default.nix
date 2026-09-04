{ lib, config, ... }: {
  imports = [
    ./cosmic-greeter.nix
    ./gdm.nix
    ./sddm.nix
  ];

  options.hostOptions.displayManagers = with lib; {
    displayManager = mkOption {
      type = types.enum [ "cosmic-greeter" "gdm" "sddm" ];
      description = "Select the display manager to use";
    };

    enableAutoLogin = mkEnableOption "Enable automatic login for the main system user";

    enableWayland = mkEnableOption "Use Wayland as the display protocol instead of X11";
  };

  config =
    let
      inherit (config.hostOptions.displayManagers) enableAutoLogin;
      inherit (config.hostOptions) user;
    in
    {
      # Enable automatic login for the main system user
      services.displayManager.autoLogin = lib.mkIf enableAutoLogin {
        enable = true;
        inherit user;
      };
    };
}
