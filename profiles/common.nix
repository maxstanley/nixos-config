{ config, pkgs, lib, ... }: {

  imports = [
    ../services/ssh.nix
    ../services/ntp.nix
    ../services/localisation.nix
  ];
  
  environment.systemPackages = with pkgs; [
    # Base Packages
    wget
    home-manager
  ];
}
