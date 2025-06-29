{
  host,
  user,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    inputs.quadlet-nix.nixosModules.quadlet

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
    nameservers = ["10.1.1.1"];
  };

  services.openssh.permitRootLogin = "yes";

  users.users.${user} = {
    uid = 101000;
    group = user;
  };

  users.groups.${user}.gid = 101000;

  system.stateVersion = "25.05";
}
