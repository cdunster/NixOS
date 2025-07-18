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
    autorandr = {
      enable = true;
      displays = {
        laptop.fingerprint = "00ffffffffffff0009e5b40c0000000034210104a51d1378070aa5a7554b9f250c505400000001010101010101010101010101010101119140a0b0807470302036001dbe1000001a000000fd001e78f4f44a010a202020202020000000fe00424f45204e4a0a202020202020000000fc004e4531333541314d2d4e59310a023170207902002000139a0e00b40c000000003417074e4531334e593121001d220b6c07400b8007886efa54b8749f56820c023554d05fd05f483512782200144c550b883f0b9f002f001f007f077300020005002500094c550b4c550b1e7880810013721a000003011e7800006a426a427800000000000000000000000000004f907020790000260009020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003690";
        homeMonitor.id = "DP-2";
      };
    };
    desktopEnvironments.gnome.enable = true;
    desktopEnvironments.cosmic.enable = true;
    displayManagers = {
      enableAutoLogin = true;
      enableWayland = true;
      displayManager = "gdm";
    };
    dconf.background.path = ../../images/backgrounds/deer_sunset.jpg;
    neovim.enable = true;
    devTools.holochain.enable = true;
    docker.enable = true;
    pico8.enable = true;
    tailscale.enable = true;
  };
}
