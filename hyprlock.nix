{ lib, pkgs, ... }: {
  home.packages = with pkgs;[
    hyprlock
  ];

  xdg.configFile."hypr/hyprlock.conf".text = lib.hm.generators.toHyprconf {
    attrs = {
      background = {
        monitor = "";
        path = "${./images/backgrounds/deer_sunset.jpg}";
        color = "rgba(25, 20, 20, 1.0)";
        blur_passes = 0; # 0 disables blurring
        blur_size = 7;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
    };
  };
}
