{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    python38
  ];
}
