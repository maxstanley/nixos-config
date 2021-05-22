{ config, pkgs, lib, ... }: {
  imports = [
    ./common.nix
    ../users/max/personal.nix
  ];
}
