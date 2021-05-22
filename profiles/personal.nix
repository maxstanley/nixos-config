{ config, pkgs, lib, ... }: {
  imports = [
    ./common.nix
	../services/development/all.nix
    ../users/max/personal.nix
  ];
}
