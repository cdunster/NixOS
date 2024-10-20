# Define all of the custom hostOptions used to configure the system for a particular host.
{ lib, config, ... }:

with lib;
{
  options.hostOptions = {
    userName = mkOption {
      type = types.nonEmptyStr;
      default = "Callum";
      description = "The displayed full name of the system user";
    };

    user = mkOption {
      type = types.str;
      default = toLower config.hostOptions.userName;
      description = "The used name of the system user";
    };

    enableVmUser = mkEnableOption "Enable the test user used inside a VM";

    allowUnfreePackages = mkOption {
      type = types.bool;
      default = true;
      description = "Allow installation of proprietary/unfree packages";
    };

    neovim = {
      enableNeorg = mkOption {
        type = types.bool;
        default = true;
        description = "Enable the Neorg plugins";
      };
    };
  };
}
