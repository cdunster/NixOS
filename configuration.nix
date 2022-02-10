{ config, pkgs, lib, ... }:
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports = [
    ./hardware-configuration.nix
  ];

  # Use the EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set the system time zone.
  time.timeZone = "Europe/Amsterdam";

  # Set the system host name.
  networking.hostName = "MiNixOS";

  # Enable WiFi.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Configure keyboard layout.
    layout = "us";
    xkbOptions = "eurosign:e";

    # Enable touchpad support.
    libinput.enable = true;

    # Use Gnome.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Exclude these packages from the Gnome install.
  environment.gnome.excludePackages = with pkgs; [
    gnome.cheese
    gnome.geary
    gnome.gnome-music
    gnome.gedit
    gnome.epiphany
    gnome.totem
    gnome-tour
    gnome.gnome-contacts
    gnome.gnome-weather
    gnome-connections
    gnome.gnome-terminal
  ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # System level packages to install (available for all users).
  environment.systemPackages = with pkgs; [
    kitty
    neovim
  ];

  # Enable the fish shell.
  programs.fish.enable = true;

  # Set kitty as the default terminal.
  environment.sessionVariables.TERMINAL = [ "kitty" ];

  # Define user accounts.
  users.users.callum = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

