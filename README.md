# NixOS Config
This repo contains the required configuration for my NixOS setup.

# Installing NixOS
Follow the latest installation instructions [here](https://nixos.org/manual/nixos/stable/index.html#sec-installation) but **before** running `nixos-generate-config` do the steps below instead.
```shell
# Install git.
nix-env -iA nixos.git

# Clone this repo into the NixOS configuration directory.
git clone https://github.com/cdunster/NixOS.git /mnt/etc/nixos

# Generate the hardware specific configuration.
nixos-generate-config --root /mnt/

# Add home-manager
/mnt/etc/nixos/add-home-manager.sh

# Install NixOS.
nixos-install
```
This will install the custom NixOS configuration. You will be prompted for the root password.

Next is just a matter of setting a password for the new user.
```shell
nixos-enter
passwd <user>
exit
```

And now reboot into the new NixOS installation.
```shell
reboot now
```
