{ config, pkgs, ... }: {
  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true;

    fonts = with pkgs; [
      dejavu_fonts
      joypixels
      ubuntu_font_family      
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Ubuntu" ];
	serif = [ "DejaVu Serif" ];
	sansSerif = [ "DejaVu Sans" ];
	emoji = [ "JoyPixels" ];
      };
    };
  };
}
