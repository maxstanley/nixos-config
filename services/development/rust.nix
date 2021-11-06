{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    rustc
    rustup
    cargo
    rust-analyzer
    rls
    rustfmt

    # to build openssl-sys
    pkg-config
    openssl
  ];
}
