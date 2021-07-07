{ config, pkgs, lib, ... }: {
  imports = [
    ./common.nix
	../services/development/all.nix
	../services/i3.nix
    ../users/max/personal.nix
  ];
}
