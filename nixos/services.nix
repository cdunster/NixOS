{ ... }: {
  services = {
    # Install firmware updates distributed through LVFS
    fwupd.enable = true;

    # Enable CUPS to print documents
    printing.enable = true;

    # Enable the GNOME secrets manager support
    gnome.gnome-keyring.enable = true;

    # Add support for Flatpaks
    flatpak.enable = true;
  };
}
