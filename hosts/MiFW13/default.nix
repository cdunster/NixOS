# Any system-specific configuration can go here.
{ inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  # Workaround for "VirtualBox can't enable the AMD-V extension. Please disable the KVM kernel extension, recompile your kernel and reboot (VERR_SVM_IN_USE)."
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  hostOptions = {
    userName = "Callum";
    allowUnfreePackages = true;
    bootloader = "lanzaboote";
    shells.fish = {
      enable = true;
      default = true;
    };
    desktopEnvironments.cosmic.enable = true;
    displayManagers = {
      enableAutoLogin = true;
      enableWayland = true;
      displayManager = "cosmic-greeter";
    };
    neovim.enable = true;
    devTools.holochain.enable = true;
    docker.enable = true;
    pico8.enable = true;
    tailscale.enable = true;
  };
}
