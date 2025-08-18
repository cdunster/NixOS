{ config, ... }: {
  config =
    let
      inherit (config.hostOptions) user;
    in
    {
      home-manager.users.${user}.programs.lazygit = {
        enable = true;
        settings = {
          notARepository = "skip";
          gui.showCommandLog = false;
          git.overrideGpg = true;
        };
      };
    };
}
