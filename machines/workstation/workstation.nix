{ config, pkgs, ... }: {
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../../profiles/personal.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "workstation";  # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.interfaces.enp7s0f0.useDHCP = true;
  networking.interfaces.enp7s0f1.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Base Packages
 #    wget
 #    neovim
 #    mpv
 #    alacritty
 #    dmenu
 #    home-manager
 #    git
 #    
 #    # Development Tools
 #    vscodium
 #    python38
 #    nodejs-slim-14_x
 #    go_1_15
 #    clang_12
 #    rustc
 #    cargo
 #    docker


  ];

  # programs.neovim.enable = true;
  # programs.firefox.enable = true;
  
  programs.tmux = {
    enable = true;
    clock24 = true;
  };

 # programs.git = {
 #   enable = true;
 #   userName = "Max Stanley";
 #   userEmail = "git@maxstanley.uk";
 # };

  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22 # SSH
    3389 # RDP
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

