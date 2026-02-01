{ config, ... }: {
  config =
    let
      inherit (config.hostOptions) user;
    in
    {
      home-manager.users.${user}.programs.claude-code = {
        enable = true;
        memory.source = ./claude-global.md;
        settings = {
          theme = "dark";
          model = "opus";
          attribution = {
            commit = "";
            pr = "";
          };
          permissions = {
            allow = [
              "Bash(tree:*)"
              "Bash(find:*)"
              "Bash(cargo build:*)"
              "Bash(cargo test:*)"
              "Bash(cargo clippy:*)"
            ];
          };
        };
      };
    };
}
