{ pkgs, ... }: {
  imports = [
    ./audio.nix
    ./bootloader.nix
    ./desktop-envs
    ./dev-tools
    ./display-managers
    ./docker.nix
    ./networking.nix
    ./programs.nix
    ./services.nix
    ./tailscale.nix
    ./time-and-locale.nix
    ./udev
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
        experimental-features = [ "nix-command" "flakes" ];
        keep-outputs = true;
        keep-derivations = true;
        download-buffer-size = 524288000; # 500MiB

        substituters = [
          # Use the new NixOS official binary cache (currently in beta)
          "https://aseipp-nix-cache.freetls.fastly.net"
        ];
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

    # Install extra system fonts
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
}
