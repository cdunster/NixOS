{ ... }: {
  config = {
    # Enable the RealtimeKit system service, which PipeWire uses to acquire realtime priority
    security.rtkit.enable = true;

    services = {
      # Use PipeWire for sound control instead of PulseAudio
      pulseaudio.enable = false;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
  };
}
