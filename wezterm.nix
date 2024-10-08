{ pkgs, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  xdg.configFile."autostart/wezterm-mux-server.desktop".text = (pkgs.makeDesktopItem {
    name = "wezterm-mux-server";
    desktopName = "WezTerm mux server";
    exec = "${pkgs.wezterm}/bin/wezterm-mux-server --daemonize";
    noDisplay = true;
  }).text;
}
