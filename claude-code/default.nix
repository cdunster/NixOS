{ config, pkgs, ... }: {
  config =
    let
      inherit (config.hostOptions) user;
    in
    {
      home-manager.users.${user}.programs.claude-code = {
        enable = true;
        context = ./claude-global.md;
        plugins = [
          (pkgs.fetchFromGitHub {
            owner = "sveltejs";
            repo = "ai-tools";
            rev = "main";
            sparseCheckout = [ "plugins/claude/svelte" ];
            hash = "sha256-wp2WEUba7clLN1DxLtWwMszLMAlcqD1TXYjBtOm26J8=";
          })
        ];
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
