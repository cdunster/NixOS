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
        hooks: {
          pre_prompt: [{
            code: "
              let direnv = (direnv export json | from json)
              let direnv = if ($direnv | length) == 1 { $direnv } else { {} }
              $direnv | load-env
            "
          }]
        }
      }
      source ~/.cache/starship/init.nu
    '';
  };
}
