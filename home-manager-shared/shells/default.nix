{ config, ... }: {
  imports = [
    ./fish.nix
  ];

  config = {
    # The custom, cross-shell shell prompt
    programs.starship = {
      enable = true;
      settings = {
        # Display the current shell in the prompt
        shell.disabled = false;
        # Set the character used on the input line of the prompt
        character = {
          success_symbol = "[=>](bold #${config.lib.stylix.colors.base05})";
          error_symbol = "[=>](bold #${config.lib.stylix.colors.red})";
        };
      };
    };

    # The modern, better cd command that remembers directories
    programs.zoxide.enable = true;

    # The modern replacement of cat with colours, paging, and other features
    programs.bat.enable = true;

    # The modern replacement of ls
    programs.eza.enable = true;

    # Automatically run scripts and setup envs when changing directory
    programs.direnv = {
      enable = true;

      # Support entering Nix devShells via direnv
      nix-direnv.enable = true;
    };

    # Set aliases to be used by all shells and all users
    home.shellAliases = {
      lg = "lazygit";
      ll = "eza -lah";
      gl = "git log --pretty=fuller";
      gll = "git log --pretty=fuller -1";
    };
  };
}
