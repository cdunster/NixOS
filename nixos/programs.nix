{ lib, config, ... }: {
  options.hostOptions = with lib; {
    enableVirtualBox = mkEnableOption "Enable VirtualBox program with extension pack";
  };

  config =
    let
      cfg = config.hostOptions;
    in
    {
      # Override default packages (removes nano and others)
      environment.defaultPackages = [ ];

      programs = {
        # Enable the GNU Privacy Guard agent for managing GPG keys
        gnupg.agent.enable = true;

        # Add support for running AppImages directly
        appimage = {
          enable = true;
          binfmt = true;
        };
      };

      # Enable VirtualBox with the expansion pack
      virtualisation.virtualbox.host = lib.mkIf cfg.enableVirtualBox {
        enable = true;
        enableExtensionPack = true;
      };
    };
}
