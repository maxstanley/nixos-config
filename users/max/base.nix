{ config, pkgs, lib, ... }: rec {
  imports = [
    <home-manager/nixos>
  ];

  users.extraUsers.max = {
    isNormalUser = true;
    extraGroups = lib.mkDefault [
      "wheel"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.max = { pkgs, ... }: {
      programs = {

        zsh = {
	  enable = true;
	};

	ssh = {
	  enable = true;
	};

	git = {
	  enable = true;
	};
	    
      };
    };
  };
}
