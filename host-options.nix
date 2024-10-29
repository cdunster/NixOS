# Define all of the custom hostOptions used to configure the system for a particular host.
{ lib, ... }:

with lib;
{
  options.hostOptions = {
    desktopEnvironment = {
      gnome = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable the GNOME desktop environment";
        };
      };
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
