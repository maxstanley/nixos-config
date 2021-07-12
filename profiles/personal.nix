{ config, pkgs, lib, ... }: {
  imports = [
    ./common.nix
	./development.nix

	../services/i3.nix
  ];
}
