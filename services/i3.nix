{ config, pkgs, lib, ... }: {

  boot.plymouth.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "gb";
    displayManager.lightdm.enable = lib.mkDefault true;
    desktopManager.xterm.enable = false;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        i3status
        i3lock
      ];
    };

  };

  services.xrdp = {
    enable = true;
    defaultWindowManager = "i3";
  };

}
