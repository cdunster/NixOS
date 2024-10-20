{ inputs, ... }: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Use the GRUB bootloader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "nodev";
  # boot.loader.grub.useOSProber = true;
  # boot.loader.grub.efiSupport = true;

  # Use lanzaboote as the bootloader to allow the use of Secure Boot.
  boot.loader.systemd-boot.enable = false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

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
