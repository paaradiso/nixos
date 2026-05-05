{
  host,
  user,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    inputs.quadlet-nix.nixosModules.quadlet
    ./podman

    ./modules

    ../../modules/core/boot.nix
    ../../modules/core/users.nix
    ../../modules/core/nix.nix
    ../../modules/secrets
    ../../modules/programs/nvf
    ../../modules/theme
  ];

  boot.zfs.extraPools = ["zpr0"];
  boot.loader.grub.enable = false;

  networking = {
    hostName = host;
    hostId = "cacabeef";
    interfaces.enp5s0.ipv4.addresses = [
      {
        address = "10.1.1.10";
        prefixLength = 24;
      }
    ];
    defaultGateway = "10.1.1.1";
    nameservers = ["10.1.1.1"];
  };

  users.users.${user} = {
    uid = 101000;
    group = user;
    subUidRanges = [
      {
        startUid = 200000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 200000;
        count = 65536;
      }
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOhMK/272nk75SORGhUiIyVxGkxQAEdl1O/Hl4tZoIkO"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJNSUANzeYfCpHxhzTJCsXSqUL+QKY9T8UYiBlO/CfH4"
    ];
    linger = true;
  };

  users.groups.${user}.gid = 101000;

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "${host}";
        "netbios name" = "${host}";
        "security" = "user";
        "map to guest" = "Bad User";
        "min protocol" = "SMB2";
      };
      "music" = {
        "path" = "/mnt/zpr0/media/library/music";
        "browseable" = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "${user}";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  system.stateVersion = "25.05";
}
