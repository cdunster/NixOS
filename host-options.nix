# Define all of the custom hostOptions used to configure the system for a particular host.
{ lib, ... }:

with lib;
{
  options.hostOptions = {
    shells = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          enable = mkEnableOption "Enable this shell";
          default = mkEnableOption "Set this shell as the default shell";
        };
      });
      default = {
        fish = {
          enable = true;
          default = true;
        };
        bash.enable = true;
        zsh.enable = false;
      };
      description = "A set of shells to enable. Only one shell can be the default";
    };

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
