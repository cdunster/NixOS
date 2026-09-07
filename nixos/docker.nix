{ lib, config, ... }:

with lib;
{
  options.hostOptions.docker = {
    enable = mkEnableOption "Enable the docker service/daemon";
  };

  config =
    let
      cfg = config.hostOptions.docker;
      user = config.hostOptions.user;
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

      # Add main system user to the docker group to provide access to the socket
      users.extraGroups.docker.members = [ "${user}" ];
    };
}
