{ inputs, lib, config, ... }: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  options.hostOptions.bootloader = with lib; mkOption {
    type = types.enum [ "grub" "systemd-boot" "lanzaboote" ];
    description = "The type of bootloader to use";
  };

  config =
    let
      cfg = config.hostOptions;
    in
    {
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
        pkiBundle = "/var/lib/sbctl";
        configurationLimit = 5;
      };

      # Use the EFI bootloader.
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.efi.efiSysMountPoint = "/boot";

      # Enable Plymouth for GUI boot screen.
      boot.initrd.systemd.enable = true;
      boot.plymouth.enable = true;
      boot.kernelParams = [ "quiet" ];

      # Allow emulating ARM (for building RPi images).
      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
    };
}
