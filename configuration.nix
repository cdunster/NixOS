{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Use the GRUB bootloader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda";
  # boot.loader.grub.useOSProber = true;

  # Use the EFI bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set the system time zone.
  time.timeZone = "Europe/Amsterdam";

  # Set the system host name.
  networking.hostName = "MiNixOS";

  # Enable WiFi.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

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
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-connections
    gnome-console # GNOME terminal emulator
    gedit # text editor
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    geary # email reader
    gnome-music
    epiphany # web browser
    totem # video player
    gnome-characters
    gnome-contacts
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    gnome-weather
    gnome-terminal
  ]);

  # Override default packages (removes nano and others).
  environment.defaultPackages = [ ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # System level packages to install (available for all users).
  environment.systemPackages = with pkgs; [
  ];

  # Enable the fish shell.
  programs.fish.enable = true;

  # Enable neovim and set as default editor.
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Enable the GNU Privacy Guard agent for managing GPG keys.
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
  };

  # Enable docker in rootless configuration.
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Enable VirtualBox.
  virtualisation.virtualbox.host.enable = true;

  # Enable udev and add custom rules.
  services.udev = {
    enable = true;
    packages =
      let
        createRule = file:
          pkgs.writeTextFile {
            name = builtins.baseNameOf file;
            text = builtins.readFile file;
            destination = "/etc/udev/rules.d/" + builtins.baseNameOf file;
          };
      in
      [
        (createRule ./udev-rules/69-probe-rs.rules)
      ];
  };

  # Define user accounts.
  users.users.callum = {
    isNormalUser = true;
    description = "Callum";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

