{ ... }: {
  # Use the Display Manager from Dux Labs, goes with the Dux Shell (f.k.a DankMaterialShell)
  services.displayManager.dux-greeter = {
    enable = true;
    compositor.name = "niri";
  };
}
