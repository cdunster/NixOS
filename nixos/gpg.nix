{ config, ... }: {
  config =
    let
      inherit (config.hostOptions) user;
    in
    {
      home-manager.users.${user}.programs.gpg.enable = true;
    };
}
