# Define all of the custom hostOptions used to configure the system for a particular host.
{ lib, ... }:

with lib;
{
  options.hostOptions = {
    neovim = {
      enableNeorg = mkOption {
        type = types.bool;
        default = true;
        description = "Enable the Neorg plugins";
      };
    };
  };
}
