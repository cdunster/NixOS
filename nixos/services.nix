{ ... }: {
  services = {
    # Install firmware updates distributed through LVFS
    fwupd.enable = true;

    # Enable fingerprint reader support
    fprintd.enable = true;

    # Allow the timezone to be set automatically
    automatic-timezoned.enable = true;

    # Enable touchpad support
    libinput.enable = true;

    # Use PipeWire for sound control instead of PulseAudio
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable CUPS to print documents
    printing.enable = true;

    # Enable the GNOME secrets manager support
    gnome.gnome-keyring.enable = true;

    # Add support for Flatpaks
    flatpak.enable = true;
  };
}
