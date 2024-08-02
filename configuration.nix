{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Use the GRUB bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;

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

  # Set the system time zone.
  time.timeZone = "Europe/Amsterdam";

  networking = {
    # Set the system host name.
    hostName = "MiNixOS";

    # Enable networking.
    networkmanager.enable = true;

    # Enable WiFi.
    wireless.enable = true; # Enables wireless support via wpa_supplicant.
  };

  # Enable bluetooth.
  hardware.bluetooth.enable = true;

  # Manage bluetooth with the blueman utility.
  services.blueman.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
  };

  services = {
    # Enable touchpad support.
    libinput.enable = true;

    # Enable automatic login for a user.
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "callum";
  };

  # Required workaround for autoLogin.
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Override default packages (removes nano and others).
  environment.defaultPackages = [ ];

  # Enable sound.
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # System level packages to install (available for all users).
  environment.systemPackages = with pkgs; [
    iwgtk # GUI application to manage WiFi connection via iwd backend
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
        (createRule ./udev-rules/90-saleae-logic.rules)
      ];
  };

  # Define user accounts.
  users.users = {
    callum = {
      isNormalUser = true;
      description = "Callum";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" ];
    };
    # Create a user to be used when testing with `build-vm`.
    # nixosvmtest = {
    #   isNormalUser = true;
    #   initialPassword = "test";
    # };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

