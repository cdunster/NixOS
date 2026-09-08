{ inputs, osConfig, ... }: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  config = {
    catppuccin = {
      inherit (osConfig.catppuccin) enable autoEnable flavor accent;
      cursors.accent = "dark";
    };
  };
}
