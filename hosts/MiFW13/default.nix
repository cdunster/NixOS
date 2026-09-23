# Any system-specific configuration can go here.
{ inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  # Workaround for "VirtualBox can't enable the AMD-V extension. Please disable the KVM kernel extension, recompile your kernel and reboot (VERR_SVM_IN_USE)."
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  # Enable Bluetooth support
  hardware.bluetooth.enable = true;

  # Enable fingerprint reader support
  services.fprintd.enable = true;

  # Don't try fingerprint authentication for pkexec/polkit as there is no
  # prompt so it looks like it's hanging for 30 seconds until the timeout
  security.pam.services.polkit-1.fprintAuth = false;

  # Enable touchpad support
  services.libinput.enable = true;

  hostOptions = {
    bootloader = "lanzaboote";
    desktopEnvironments.niri.enable = true;
    devTools.holochain.enable = true;
    docker.enable = true;
    tailscale.enable = true;
  };
}
