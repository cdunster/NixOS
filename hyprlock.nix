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
      label = [
        {
          monitor = "";
          text = "cmd[update:1000] date \"+%T\"";
          text_align = "center";
          font_size = 128;
          font_family = "JetBrainsMono";
          position = "0, 10";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] date \"+%A %B %d %Y\"";
          text_align = "center";
          font_size = 18;
          font_family = "JetBrainsMono";
          position = "0, -80";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = {
        monitor = "";
        size = "300, 50";
        outline_thickness = 2;
        position = "0, -130";
      };
    };
  };
}
