{ pkgs, ... }: {
  home.packages = with pkgs; [
    taskwarrior-tui
  ];

  programs.fish.shellAliases.tw = "taskwarrior-tui";

  programs.taskwarrior.enable = true;
}
