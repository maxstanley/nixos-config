{ config, ... }: {
  imports = [
    ./c_cpp.nix
	./docker.nix
	./golang.nix
	./node_14.nix
	./python3.nix
    ./rust.nix
  ];
}
