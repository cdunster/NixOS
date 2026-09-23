{ lib, config, ... }: {
  options.hostOptions.desktopEnvironments.niri = with lib; {
    enable = mkEnableOption "Enable the niri compositor with the DankMaterialShell desktop shell";
  };

  config =
    let
      cfg = config.hostOptions.desktopEnvironments.niri;
    in
    lib.mkIf cfg.enable {
      programs.niri.enable = true;
      programs.dms-shell.enable = true;

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Hint to electron apps to use Wayland
      };
    };
}
