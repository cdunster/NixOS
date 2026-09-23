{ ... }: {
  # Use the Display Manager from Dank Linux, goes with the DankMaterialShell
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
  };
}
