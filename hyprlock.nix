{ ... }: {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        monitor = "";
        path = "${./images/backgrounds/deer_sunset.jpg}";
        color = "rgba(25, 20, 20, 1.0)";
        blur_passes = 3;
        blur_size = 12;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
      label = {
        monitor = "";
        text = "$TIME";
        text_align = "center";
        font_size = 128;
        font_family = "Unifont";
        position = "0, -100";
        halign = "center";
        valign = "top";
      };
      input-field = {
        monitor = "";
        size = "300, 50";
        outline_thickness = 2;
      };
    };
  };
}
