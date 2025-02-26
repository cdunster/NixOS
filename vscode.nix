{ pkgs, config, ... }: {
  config =
    let
      inherit (config.hostOptions) user;
    in
    {
      home-manager.users.${user}.programs.vscode = {
        enable = true;
        profiles.default.extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
          rust-lang.rust-analyzer
          vadimcn.vscode-lldb
        ];
      };
    };
}
