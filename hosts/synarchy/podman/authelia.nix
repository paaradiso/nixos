{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "9091";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.authelia = {
    containerConfig = {
      image = "docker.io/authelia/authelia:latest";
      autoUpdate = "registry";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/authelia:/config"
      ];
      environments = {
        PUID = "101000";
        PGID = "101000";
      };
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "lldap.service redis.service";
    };
  };

  services.caddy.virtualHosts."auth.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
