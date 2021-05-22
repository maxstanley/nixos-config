#/bin/sh

# Common Steps.
if [ "$EUID" -ne 0 ]; then
	echo "Run as root"
	exit
fi

# Install git.
nix-env -iA nixos.git

# Clone nixos-config repo.
git clone https://github.com/maxstanley/nixos-config.git

# Unique Steps.

parted /dev/sda -- mklabel msdos
parted /dev/sda -- mkpart primary 1MiB -8GiB
parted /dev/sda -- mkpart primary linux-swap -8GiB 100%

# https://nixos.org/manual/nixos/stable/#sec-installation-summary
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
swapon /dev/sda2
mount /dev/disk/by-label/nixos /mnt
nixos-generate-config --root /mnt

rm /mnt/etc/nixos/configuration.nix
cd nixos-config
# TODO: Remove this line once merged.
git checkout intial
ln -s $HOME/nixos-config/machines/virtual/virtual.nix /mnt/etc/nixos/configuration.nix

nixos-install

