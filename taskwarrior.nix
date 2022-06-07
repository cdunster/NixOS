{ pkgs, ... }: {
  home.packages = with pkgs; [
    taskwarrior-tui
  ];

  programs.fish.shellAliases.tw = "taskwarrior-tui";

  programs.tmux.extraConfig = ''
    bind t popup -E -h 90% -w 90% "taskwarrior-tui"
  '';

  programs.taskwarrior.enable = true;
}
