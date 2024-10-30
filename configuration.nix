{ pkgs, lib, config, ... }: {
  imports = [
    ./bootloader.nix
    ./dconf
    ./desktop-envs
    ./dev-tools
    ./fonts.nix
    ./git.nix
    ./home-manager.nix
    ./neovim
    ./shells
    ./terminals
    ./themes
    ./udev
  ];

  options.hostOptions = with lib; {
    userName = mkOption {
      type = types.nonEmptyStr;
      description = "The displayed full name of the main system user";
    };

    user = mkOption {
      type = types.str;
      default = toLower config.hostOptions.userName;
      description = "The used name of the system user";
    };

    enableVmUser = mkEnableOption "Enable the test user used inside a VM";

    allowUnfreePackages = mkEnableOption "Allow installation of proprietary/unfree packages";
  };

  config =
    let
      cfg = config.hostOptions;
    in
    {
      # Allow proprietary/unfree packages to be installed
      nixpkgs.config.allowUnfree = cfg.allowUnfreePackages;

      # Nix configuration
      nix = {
        # Set nixpkgs version to the latest unstable version
        package = pkgs.nixVersions.latest;

        # Extra lines to be added to /etc/nix/nix.conf
        extraOptions = ''
          experimental-features = nix-command flakes
          keep-outputs = true
          keep-derivations = true
        '';
      };

      # Install firmware updates distributed through LVFS.
      services.fwupd.enable = true;

      # Enable fingerprint reader support.
      services.fprintd.enable = true;

      # Set the system time zone.
      time.timeZone = "Europe/Amsterdam";

      # Enable networking.
      networking.networkmanager.enable = true;

      # Select internationalisation properties.
      i18n.defaultLocale = "en_GB.UTF-8";

      i18n.extraLocaleSettings = {
        LC_CTYPE = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
        LC_COLLATE = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_MESSAGES = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_ADDRESS = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_ALL = "en_GB.UTF-8";
      };

      services = {
        # Enable touchpad support.
        libinput.enable = true;

        # Enable automatic login for a user.
        displayManager.autoLogin.enable = true;
        displayManager.autoLogin.user = cfg.user;
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

      # Define user accounts.
      users.users = {
        ${cfg.user} = {
          isNormalUser = true;
          description = cfg.userName;
          extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" ];
        };
        # Create a user to be used when testing with `build-vm`.
        nixosvmtest = lib.mkIf cfg.enableVmUser {
          isNormalUser = true;
          initialPassword = "test";
        };
      };

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "23.11"; # Did you read the comment?
    };
}
