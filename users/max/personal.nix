{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "2aa20ae969f2597c4df10a094440a66e9d7f8c86";
    ref = "release-20.09";
  };
in {
  imports = [
    # <home-manager/nixos>
    (import "${home-manager}/nixos")
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

          history = {
              size = 1000;
	      save = 1000;
	      path = "$HOME/.zsh_history";
	      share = true;
	  };

#	  histSize = 1000;
#	  setOptions = [
#
#	  ];
	};

	ssh = {
	  enable = true;
	};

	git = {
	  enable = true;
          userName = "Max Stanley";
          userEmail = "git@maxstanley.uk";
	};
	    
      };
    };
  };
}
