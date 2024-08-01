{ ... }: {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        monitor = "";
        path = "screenshot";
        color = "rgba(25, 20, 20, 1.0)";
        blur_passes = 3;
        blur_size = 12;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
      input-field = {
        monitor = "";
        size = "200, 50";
        outline_thickness = 3;
      };
    };
  };
}
