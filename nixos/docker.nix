{ lib, config, ... }:

with lib;
{
  options.hostOptions.docker = {
    enable = mkEnableOption "Enable the docker service/daemon";
  };

  config =
    let
      cfg = config.hostOptions.docker;
    in
    mkIf cfg.enable {
      virtualisation.docker = {
        enable = true;

        rootless = {
          # Enable rootless configuration for docker
          enable = true;

          # Set the DOCKER_HOST variable to the rootless Docker instance
          setSocketVariable = true;
        };
      };
    };
}
