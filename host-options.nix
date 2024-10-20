# Define all of the custom hostOptions used to configure the system for a particular host.
{ pkgs, lib, config, ... }:

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
      type = types.nonEmptyListOf (types.enum [ "fish" "bash" "zsh" ]);
      default = [ "fish" "bash" ];
      description = "The list of shells to install. Element 0 is considered the default unless overridden with defaultShellPackage";
    };

    defaultShellPackage = mkOption {
      type = types.shellPackage;
      default = pkgs."${builtins.elemAt config.hostOptions.shells 0}";
      description = "The package to use as the default shell";
    };

    neovim = {
      enableNeorg = mkOption {
        type = types.bool;
        default = true;
        description = "Enable the Neorg plugins";
      };
    };

    extraHomePackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "A list of extra packages to be installed via home-manager";
    };
  };
}
