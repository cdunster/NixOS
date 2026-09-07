{ ... }: {
  imports = [
    ./claude-code
    ./dconf
  ];

  config = {
    # Add user profile picture.
    home.file.".face".source = ../../../images/backgrounds/deer_sunset.jpg;
  };
}
