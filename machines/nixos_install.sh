#!/bin/sh

nixos_config_dir="/etc/nixos-config"
nixos_config_dir_mnt="/mnt/etc/nixos-config"

nixos_dir="/etc/nixos"
nixos_dir_mnt="/mnt/etc/nixos"

check_run_as_root() {
	# Check we are running as root.
	if [ "$EUID" -ne 0 ]; then
		echo "Run as root"
		exit
	fi
}

get_configuration() {
	# Install git.
	nix-env -iA nixos.git
	
	# Clone nixos-config repo.
	git clone $1 $nixos_config_dir_mnt/
	
	cd $nixos_config_dir_mnt
	git checkout update
}

nixos_install() {
	cd $nixos_config_dir_mnt
	sed -i 's/\/etc\/nixos/\/mnt\/etc\/nixos/g' ./configuration.nix
	
	nixos-install --no-root-passwd
	
	sed -i 's/\/mnt\/etc\/nixos/\/etc\/nixos/g' ./configuration.nix
}

set_root_password() {
	echo -e "$1\n$1" | passwd --root /mnt
}

generate_configuration() {
	nixos-generate-config --root /mnt

	rm $nixos_dir_mnt/configuration.nix
	cd $nixos_dir_mnt
	ln -s ../nixos-config/machines/$1/$1.nix configuration.nix
}

check_run_as_root

# Machine dependent steps.
source machine.sh

get_configuration $NIXOS_REPO
generate_configuration $NIXOS_MACHINE
nixos_install
set_root_password $NIXOS_ROOT_PASSWORD

