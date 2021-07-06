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

parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart primary 512MiB -16GiB
parted /dev/sda -- mkpart primary linux-swap -16GiB 100%
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- set 3 esp on

# https://nixos.org/manual/nixos/stable/#sec-installation-summary
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
swapon /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
nixos-generate-config --root /mnt

cd nixos-config
# TODO: Remove this line once merged.
git checkout intial

rm /mnt/etc/nixos/configuration.nix
ln -s /home/nixos/nixos-config/machines/virtual/virtual.nix /mnt/etc/nixos/configuration.nix

sed -i 's/\/etc\/nixos/\/mnt\/etc\/nixos/g' ./machines/virtual/virtual.nix

nixos-install

sed -i 's/\/mnt\/etc\/nixos/\/etc\/nixos/g' ./machines/virtual/virtual.nix
