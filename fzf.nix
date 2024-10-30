{ config, ... }: {
  config =
    let
      inherit (config.hostOptions) user;
    in
    {
      home-manager.users.${user}.programs.fzf = {
        enable = true;
        defaultCommand = "fd --type=f --hidden --exclude=.git";
        defaultOptions = [
          "--inline-info"
          "--reverse"
          "--height=30"
          "--header-first"
        ];
      };
    };
}
