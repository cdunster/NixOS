{ pkgs, lib, config, ... }: {
  imports = [
    ./bootloader.nix
    ./brave.nix
    ./claude-code
    ./dconf
    ./desktop-envs
    ./dev-tools
    ./display-managers
    ./docker.nix
    ./fonts.nix
    ./git.nix
    ./gpg.nix
    ./helix.nix
    ./home-manager.nix
    ./neovim
    ./shells
    ./tailscale.nix
    ./terminals
    ./themes
    ./udev
    ./users.nix
  ];

  options.hostOptions = with lib; {
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

        # System garbage collection to free-up space
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 14d --delete-old";
        };
      };

      # Set the system timezone.
      time.timeZone = lib.mkDefault "Europe/Amsterdam";

      # Manage networks with networkmanager.
      networking.networkmanager = {
        enable = true;

        # Enable OpenVPN support.
        plugins = with pkgs; [
          networkmanager-openvpn
        ];
      };

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

      # Override default packages (removes nano and others).
      environment.defaultPackages = [ ];

      # Enable the RealtimeKit system service, which PipeWire uses to acquire realtime priority
      security.rtkit.enable = true;

      # Enable Bluetooth support
      hardware.bluetooth.enable = cfg.enableBluetooth;

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

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "23.11"; # Did you read the comment?
    };
}
