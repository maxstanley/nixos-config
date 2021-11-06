{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    clang_12
  ];
}
