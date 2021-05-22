{ config, pkgs, lib, ... }: {

  imports = [
    ./alacritty.nix
  ];

  boot.plymouth.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = lib.mkDefault true;
    
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
	i3status
	i3lock
      ];
    };

  };

}
