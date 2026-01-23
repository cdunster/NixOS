{ pkgs, lib, config, ... }: {
  imports = [
    ./bat.nix
    ./bootloader.nix
    ./brave.nix
    ./dconf
    ./desktop-envs
    ./dev-tools
    ./direnv.nix
    ./display-managers
    ./docker.nix
    ./eza.nix
    ./fonts.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./helix.nix
    ./home-manager.nix
    ./lazygit.nix
    ./neovim
    ./pico-8.nix
    ./shells
    ./tailscale.nix
    ./terminals
    ./themes
    ./udev
    ./vscode.nix
    ./zoxide.nix
  ];

  options.hostOptions = with lib; {
    userName = mkOption {
      type = types.nonEmptyStr;
      description = "The displayed full name of the main system user";
    };

    user = mkOption {
      type = types.nonEmptyStr;
      default = toLower config.hostOptions.userName;
      description = "The used name of the system user";
    };

    enableVmUser = mkEnableOption "Enable the test user used inside a VM";

    enableVirtualBox = mkEnableOption "Enable VirtualBox program with extension pack";

    allowUnfreePackages = mkEnableOption "Allow installation of proprietary/unfree packages";

    enableBluetooth = mkEnableOption "Enable Bluetooth support for this machine";
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
        settings = {
          experimental-features = "nix-command flakes";
          keep-outputs = true;
          keep-derivations = true;
          download-buffer-size = 524288000; # 500MiB
        };
      };

      # Install firmware updates distributed through LVFS.
      services.fwupd.enable = true;

      # Enable fingerprint reader support.
      services.fprintd.enable = true;

      # Set the system timezone.
      time.timeZone = lib.mkDefault "Europe/Amsterdam";

      # Allow the timezone to be set automatically.
      services.automatic-timezoned.enable = true;

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

      # Enable touchpad support.
      services.libinput.enable = true;

      # Override default packages (removes nano and others).
      environment.defaultPackages = [ ];

      # Enable sound.
      services.pulseaudio.enable = false;
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

      # Enable Bluetooth support
      hardware.bluetooth.enable = cfg.enableBluetooth;

      # Enable CUPS to print documents.
      services.printing.enable = true;

      # Enable the GNU Privacy Guard agent for managing GPG keys.
      programs.gnupg.agent = {
        enable = true;
      };

      # Add support for running AppImages directly
      programs.appimage = {
        enable = true;
        binfmt = true;
      };

      # Enable VirtualBox with the expansion pack
      virtualisation.virtualbox.host = lib.mkIf cfg.enableVirtualBox {
        enable = true;
        enableExtensionPack = true;
      };

      # Define user accounts.
      users.users = {
        ${cfg.user} = {
          isNormalUser = true;
          description = cfg.userName;
          extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
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
