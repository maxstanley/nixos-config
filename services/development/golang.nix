{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    go_1_16
	go-tools
  ];
}
