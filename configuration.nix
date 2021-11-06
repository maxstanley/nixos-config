{ config, pkgs, ... }: {
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      /etc/nixos-config/profiles/personal.nix
    ];

  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.max = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  nix.trustedUsers = [ "root" "max" ];

  # Override defualt packages (removes nano)
  environment.defaultPackages = with pkgs; [];
  environment.variables.EDITOR = "nvim";

  system.stateVersion = "21.05";

}

