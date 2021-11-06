#/bin/sh

parted --script /dev/sda -- \
	mklabel gpt
	mkpart primary 512MiB -16GiB \
	mkpart primary linux-swap -16GiB 100% \
	mkpart ESP fat32 1MiB 512MiB \
	set 3 esp on

# https://nixos.org/manual/nixos/stable/#sec-installation-summary
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
swapon /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
