{ pkgs, ... }: {
  imports = [
    ./audio.nix
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
    ./programs.nix
    ./shells
    ./tailscale.nix
    ./terminals
    ./themes
    ./time-and-locale.nix
    ./udev
    ./users.nix
  ];

  config = {
    # Allow proprietary/unfree packages to be installed
    nixpkgs.config.allowUnfree = true;

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

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11"; # Did you read the comment?
  };
}
