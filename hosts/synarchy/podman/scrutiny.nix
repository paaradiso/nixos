{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8080";
  externalPort = "8083";
in {
  virtualisation.quadlet.containers.scrutiny = {
    containerConfig = {
      image = "ghcr.io/analogj/scrutiny:master-omnibus";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/run/udev:/run/udev:ro"
        "/mnt/zpr0/apps/scrutiny/config:/opt/scrutiny/config"
        "/mnt/zpr0/apps/scrutiny/influxdb:/opt/scrutiny/influxdb"
      ];
      devices = ["/dev/disk/by-id/wwn-0x5000cca264f77812" "/dev/disk/by-id/wwn-0x5000cca290c7ea87" "/dev/disk/by-id/wwn-0x5000cca2a3cc27c3" "/dev/disk/by-id/wwn-0x5000cca264f75887"];
      addCapabilities = ["SYS_RAWIO"];
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "authelia.service";
    };
  };
  services.caddy.virtualHosts."scrutiny.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:8083
  '';
}
