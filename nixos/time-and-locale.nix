{ lib, ... }: {
  config = {
    # Set the system timezone.
    time.timeZone = lib.mkDefault "Europe/Amsterdam";

    # Allow the timezone to be set automatically
    services.automatic-timezoned.enable = true;

    # Select internationalisation properties.
    i18n = {
      defaultLocale = "en_GB.UTF-8";
      extraLocaleSettings = {
        LC_CTYPE = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
        LC_COLLATE = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_MESSAGES = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_ADDRESS = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_ALL = "en_GB.UTF-8";
      };
    };
  };
}
