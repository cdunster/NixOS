{ lib, pkgs, ... }: {
  home.packages = with pkgs;[
    hyprpaper
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = lib.hm.generators.toHyprconf {
    attrs =
      let
        wallpaperPath = ./images/backgrounds/deer_sunset.jpg;
      in
      {
        preload = "${wallpaperPath}";
        wallpaper = ",${wallpaperPath}";
      };
  };
}
