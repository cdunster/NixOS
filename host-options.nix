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

    bootloader = mkOption {
      type = types.enum [ "grub" "systemd-boot" "lanzaboote" ];
      default = "lanzaboote";
      description = "The type of bootloader to use";
    };

    allowUnfreePackages = mkOption {
      type = types.bool;
      default = true;
      description = "Allow installation of proprietary/unfree packages";
    };

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
