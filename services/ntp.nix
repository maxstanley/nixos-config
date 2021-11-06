{ config, lib, ... }: {
  services.ntp.enable = true;

  services.timesyncd = {
    enable = lib.mkDefault true;
    servers = [
      "0.uk.pool.ntp.org"
      "1.uk.pool.ntp.org"
      "2.uk.pool.ntp.org"
      "3.uk.pool.ntp.org"
    ];
  };
}
