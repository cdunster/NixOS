{ lib, config, ... }: {
  options.hostOptions = with lib; {
    userName = mkOption {
      type = types.nonEmptyStr;
      description = "The displayed full name of the main system user";
    };

    user = mkOption {
      type = types.nonEmptyStr;
      default = toLower config.hostOptions.userName;
      description = "The used name of the system user";
    };

    enableVmUser = mkEnableOption "Enable the test user used inside a VM";
  };

  config =
    let
      cfg = config.hostOptions;
    in
    {
      # Define user accounts.
      users.users = {
        ${cfg.user} = {
          isNormalUser = true;
          description = cfg.userName;
          extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
        };
        # Create a user to be used when testing with `build-vm`.
        nixosvmtest = lib.mkIf cfg.enableVmUser {
          isNormalUser = true;
          initialPassword = "test";
        };
      };
    };
}
