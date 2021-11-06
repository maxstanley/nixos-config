{ config, pkgs, lib, ... }: {
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    # passwordAuthentication = lib.mkDefault false;
    passwordAuthentication = lib.mkDefault true;
  };
}
