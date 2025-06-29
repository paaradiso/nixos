{host, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/core/boot.nix
    ../../modules/core/users.nix
    ../../modules/core/nix.nix
    ../../modules/secrets
    ../../modules/programs/nvf.nix
    ../../modules/theme
  ];

  boot.loader.grub.enable = false;

  networking = {
    hostName = host;
    hostId = "cacabeef";
    interfaces.ens18.ipv4.addresses = [
      {
        address = "10.1.1.40";
        prefixLength = 24;
      }
    ];
    defaultGateway = "10.1.1.1";
    nameservers = "10.1.1.1";
  };

  system.stateVersion = "25.05";
}
