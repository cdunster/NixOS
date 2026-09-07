# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "ca/desrt/dconf-editor" = {
      show-warning = false;
    };

    "org/gnome/Geary" = {
      autoselect = false;
      run-in-background = true;
    };

    "org/gnome/calculator" = {
      button-mode = "programming";
    };

    "org/gnome/calendar" = {
      active-view = "week";
    };

    "org/gtk/settings/color-chooser" = {
      custom-colors = [ (mkTuple [ 1.0 1.0 ]) ];
      selected-color = mkTuple [ true 0.960784 ];
    };

  };
}
