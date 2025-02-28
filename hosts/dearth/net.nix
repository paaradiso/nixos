{
  networking = {
    useDHCP = false;
    interfaces.eno1 = {
      ipv4.addresses = [
        {
          address = "10.1.20.10";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "10.1.20.1";
    nameservers = [ "10.1.20.1" ];
  };
}
