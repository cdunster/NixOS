# NixOS Config
This repo contains the required configuration for my NixOS setup.

# Installing NixOS
Follow the latest installation instructions [here](https://nixos.org/manual/nixos/stable/index.html#sec-installation) but **before** running `nixos-generate-config` do the steps below instead.
```shell
# Enter a Nix shell with git and flakes enabled.
nix-shell -p git nixUnstable

# Clone this repo into the NixOS configuration directory.
git clone https://github.com/cdunster/NixOS.git /mnt/etc/nixos

# Generate the hardware specific configuration.
nixos-generate-config --root /mnt/

# Install NixOS.
nixos-install --flake /mnt/etc/nixos#MiNixOS
```
This will install the custom NixOS configuration. You will be prompted for the root password.

Next, set a password for the new user.
```shell
nixos-enter
passwd callum
exit
```

And now reboot into the new NixOS installation.
```shell
reboot
```

# Modifying NixOS
Make changes to the files in `/etc/nixos/` to modify the installation.
If you followed the installation steps then this directory should be a clone of this repo.
You need super root privileges to modify this directory.
```shell
sudo nvim /etc/nixos/configuration.nix
```

After making changes then rebuild NixOS and switch to this new build.
```shell
sudo nixos-rebuild switch --flake /etc/nixos#
```
