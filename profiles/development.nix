{ config, pkgs, lib, ... }: {

  imports = [
    ../services/development/all.nix
  ];
  
  environment.systemPackages = with pkgs; [
	silver-searcher
  ];

}
