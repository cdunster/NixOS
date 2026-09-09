{ config, ... }: {
  programs = {
    # The custom, cross-shell shell prompt
    starship = {
      enable = true;
      settings = {
        # Display the current shell in the prompt
        shell.disabled = false;
        # Set the character used on the input line of the prompt
        character = {
          success_symbol = "[⇒](bold #${config.lib.stylix.colors.base05})";
          error_symbol = "[⇏](bold #${config.lib.stylix.colors.red})";
        };
      };
    };

    # The modern, better cd command that remembers directories
    zoxide.enable = true;

    # The modern replacement of cat with colours, paging, and other features
    bat.enable = true;

    # The modern replacement of ls
    eza.enable = true;

    # Command-line fuzzy-finding tool
    fzf = {
      enable = true;
      defaultCommand = "fd --type=f --hidden --exclude=.git";
      defaultOptions = [
        "--inline-info"
        "--reverse"
        "--height=30"
        "--header-first"
      ];
    };

    # A very nice TUI for managing git repos
    lazygit = {
      enable = true;
      settings = {
        notARepository = "skip";
        gui.showCommandLog = false;
        git.overrideGpg = true;
      };
    };

    # Automatically run scripts and setup envs when changing directory
    direnv = {
      enable = true;

      # Support entering Nix devShells via direnv
      nix-direnv.enable = true;
    };
  };
}
