{ lib, config, ... }:
let
  cfg = config.hostOptions.displayManagers;
in
lib.mkIf (cfg.displayManager == "cosmic-greeter") {
  assertions = [
    {
      assertion = cfg.enableWayland;
      message = "cosmic-greeter only works on Wayland";
    }
  ];

  # Use the Display Manager from System76 shipped with the COSMIC DE.
  services.displayManager.cosmic-greeter = {
    enable = true;
  };
}
