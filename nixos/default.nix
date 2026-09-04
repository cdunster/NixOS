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
    ./networking.nix
    ./shells
    ./tailscale.nix
    ./terminals
    ./themes
    ./time-and-locale.nix
    ./udev
    ./users.nix
  ];

  options.hostOptions = with lib; {
    enableVirtualBox = mkEnableOption "Enable VirtualBox program with extension pack";

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

      # Override default packages (removes nano and others).
      environment.defaultPackages = [ ];

      # Enable the RealtimeKit system service, which PipeWire uses to acquire realtime priority
      security.rtkit.enable = true;

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
