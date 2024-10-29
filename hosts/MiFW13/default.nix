# Any system-specific configuration can go here.
{ inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  hostOptions = {
    userName = "Callum";
    allowUnfreePackages = true;
    bootloader = "lanzaboote";
    shells.fish = {
      enable = true;
      default = true;
    };
  };
}
