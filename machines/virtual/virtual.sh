#/bin/sh

# Unique Steps.
parted --script /dev/sda -- \
    mklabel msdos \
    mkpart primary 1MiB -8GiB \
    mkpart primary linux-swap -8GiB 100%

# https://nixos.org/manual/nixos/stable/#sec-installation-summary
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
swapon /dev/sda2
mount /dev/disk/by-label/nixos /mnt
