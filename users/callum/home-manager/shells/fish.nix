{ ... }: {
  config = {
    programs.fish = {
      enable = true;
      functions = {
        _fzf_open_file_nvim = {
          body = ''
            set _selected (fzf --multi --preview="bat {1} --color=always" --header="Open in nvim:")
            if test -n "$_selected"
                nvim $_selected
            end

            commandline --function repaint
          '';
        };
        _open_neovim = {
          body = ''
            if test -e Session.vim
                nvim -S Session.vim
            else if test -e ../Session.vim
                nvim -S ../Session.vim
            else
              read -n 1 -l -P 'No Session.vim found, create one? [Y/n] ' _answer
              commandline --function repaint

              switch $_answer
                  case "" Y y
                      nvim -c Obsession
              end
            end
          '';
        };
        _open_helix = {
          body = "hx .";
        };
      };
      shellInit = ''
        bind \cf _fzf_open_file_nvim
        bind \cn _open_neovim
        bind \ch _open_helix
      '';
    };
  };
}
