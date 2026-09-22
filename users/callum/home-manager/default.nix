{ ... }: {
  imports = [
    ./claude-code
    ./dconf.nix
    ./helix.nix
    ./neovim
    ./shells
    ./terminals
  ];

  config = {
    # Add user profile picture.
    home.file.".face".source = ../../../images/backgrounds/deer_sunset.jpg;

    # User-specific git settings
    programs.git.settings.user = {
      name = "Callum Dunster";
      email = "cdunster@users.noreply.github.com";
    };
  };
}
