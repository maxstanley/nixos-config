{ config, pkgs, lib, ... }: {
  imports = [
    ./common.nix
    ../users/max/base.nix
    ../users/max/personal.nix
  ];
}
