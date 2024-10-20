{ inputs, pkgs, lib, config, ... }:
let
  cfg = config.hostOptions;
in
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Use the GRUB bootloader.
  boot.loader.grub = lib.mkIf (cfg.bootloader == "grub") {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };

  boot.loader.systemd-boot.enable = cfg.bootloader == "systemd-boot";

  # Use lanzaboote as the bootloader to allow the use of Secure Boot.
  boot.lanzaboote = lib.mkIf (cfg.bootloader == "lanzaboote") {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  # Install `sbctl`, a Secure Boot key manager is lanzaboote is enabled
  hostOptions.extraHomePackages = lib.optional (cfg.bootloader == "lanzaboote") pkgs.sbctl;

  # Use the EFI bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Enable Plymouth for GUI boot screen.
  boot.initrd.systemd.enable = true;
  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };
  boot.kernelParams = [ "quiet" ];

  # Allow emulating ARM (for building RPi images).
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
