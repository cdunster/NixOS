{ lib, config, ... }: {
  imports = [
    ./gdm.nix
  ];

  options.hostOptions.displayManagers.enableAutoLogin = lib.mkEnableOption "Enable automatic login for the main system user";

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
