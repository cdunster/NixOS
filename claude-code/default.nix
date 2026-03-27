{ config, ... }: {
  config =
    let
      inherit (config.hostOptions) user;
    in
    {
      home-manager.users.${user}.programs.claude-code = {
        enable = true;
        memory.source = ./claude-global.md;
        mcpServers = {
          dart = {
            type = "stdio";
            command = "dart";
            args = [ "mcp-server" ];
            env = { };
          };
        };
        settings = {
          theme = "dark";
          model = "opusplan";
          attribution = {
            commit = "";
            pr = "";
          };
          spinnerVerbs = {
            mode = "replace";
            verbs = [ "Calculating" "Computing" ];
          };
          permissions = {
            allow = [
              "Bash(tree:*)"
              "Bash(find:*)"
              "Bash(grep:*)"
              "Bash(cargo build:*)"
              "Bash(cargo fmt:*)"
              "Bash(cargo test:*)"
              "Bash(cargo clippy:*)"
              "Bash(cargo check:*)"
              "Bash(cargo doc:*)"
            ];
          };
        };
      };
    };
}
