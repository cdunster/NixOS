# This should be replaced by `nixos-generate-config`.
{ ... }:
{
    boot.loader.systemd-boot.enable = true;
    fileSystems."/".device = "/dev/disk/by-label/nixos";
}
