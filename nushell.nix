{ pkgs, ... }: {
  programs.nushell = {
    enable = true;
    envFile.text = ''
      mkdir ~/.cache/starship
      starship init nu | save ~/.cache/starship/init.nu
    '';
    configFile.text = ''
      let-env config = {
          show_banner: false
      }
      source ~/.cache/starship/init.nu
    '';
  };
}
