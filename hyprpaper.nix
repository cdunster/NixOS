{ ... }: {
  services.hyprpaper = {
    enable = true;
    settings =
      let
        wallpaperPath = ./images/backgrounds/deer_sunset.jpg;
      in
      {
        preload = "${wallpaperPath}";
        wallpaper = ",${wallpaperPath}";
        splash = false;
      };
  };
}
