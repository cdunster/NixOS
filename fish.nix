{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      lg = "lazygit";
      ll = "exa -lah";
    };
    shellAbbrs = {
      d = "pushd";
      ".." = "popd";
    };
    functions = {
      _fzf_open_file_nvim = {
        body = ''
          set _selected (fzf-tmux -p --multi --preview="_fzf_preview_file {}" --header="Open in nvim:")
          if test -n "$_selected"
              nvim $_selected
          end

          commandline --function repaint
        '';
      };
      _fzf_start_tmuxinator = {
        body = ''
          set _projects (tmuxinator list --newline)
          set _result (printf '%s\n' $_projects | fzf-tmux -p --header-lines=1 --print-query)
          set _query $_result[1]
          set _selected $_result[2]

          if contains "$_selected" $_projects
              tmuxinator start $_selected
          else if test -n "$_query"
              tmuxinator new $_query
          end

          commandline --function repaint
        '';
      };
    };
    shellInit = ''
      set -g fish_greeting ""

      bind \cf "_fzf_open_file_nvim"
      bind \cp "_fzf_start_tmuxinator"
    '';
  };
}
