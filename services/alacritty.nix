{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    alacritty
  ];

  environment.sessionVariables.TERMINAL = [ "alacritty" ];
}
