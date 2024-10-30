{ config, ... }: {
  config =
    let
      inherit (config.hostOptions) user;
    in
    {
      home-manager.users.${user}.programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
}
