{
  config,
  pkgs,
  inputs,
  host,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490s

    ../../modules/system/virtualisation.nix
  ];

  boot.initrd.luks.devices = {
    cryptkey = {
      device = "/dev/disk/by-uuid/e59891d2-1558-4760-b4af-7ec368b76b58";
    };
    cryptswap = {
      device = "/dev/disk/by-uuid/ab38e327-219c-4701-8dc5-a9d51245a69c";
      keyFileSize = 8192;
      keyFile = "/dev/mapper/cryptkey";
    };
    cryptroot = {
      device = "/dev/disk/by-uuid/ad7efceb-ce92-4ec4-9fb2-8a8a096d5740";
      keyFileSize = 8192;
      keyFile = "/dev/mapper/cryptkey";
      allowDiscards = true;
    };
  };

  networking.hostName = host;
  networking.hostId = "feedaaaa";

  system.stateVersion = "24.11";
}
