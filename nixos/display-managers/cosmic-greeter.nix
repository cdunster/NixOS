{ ... }: {
  # Use the Display Manager from System76 shipped with the COSMIC DE.
  services.displayManager.cosmic-greeter = {
    enable = true;
  };
}
