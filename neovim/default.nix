{ inputs, lib, config, ... }:
let
  cfg = config.hostOptions.neovim;
in
{
  # Add the overlay to install the latest version of neorg
  nixpkgs.overlays = lib.optional cfg.enableNeorg inputs.neorg-overlay.overlays.default;

  # Enable neovim and set as default editor.
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
