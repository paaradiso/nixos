{ config, pkgs, inputs, host, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/hardware/easyeffects-akg-k371-brainwavz-oval.nix
    ];

  boot.initrd.luks.devices = {
    cryptkey = {
      device = "/dev/disk/by-uuid/4280abbf-0b71-4311-a8a5-d3b885d275a6";
    };
    cryptswap = {
      device = "/dev/disk/by-uuid/1b6679d0-cdb8-4886-b82c-b7b1b4ea6f4d";
      keyFileSize = 8192;
      keyFile = "/dev/mapper/cryptkey";
    };
    cryptroot = {
      device = "/dev/disk/by-uuid/63b33eb5-01fb-42ca-af0b-b71c954f02e9";
      keyFileSize = 8192;
      keyFile = "/dev/mapper/cryptkey";
      allowDiscards = true;
    };
  };

  networking.hostName = host;
  networking.hostId = "fafafafa";
}

