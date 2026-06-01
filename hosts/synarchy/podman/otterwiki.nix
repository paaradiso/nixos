{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "80";
  externalPort = "8095";
in {
  virtualisation.quadlet.containers.otterwiki = {
    containerConfig = {
      image = "docker.io/redimp/otterwiki:2.20";
      autoUpdate = "registry";
      publishPorts = [
        "${externalPort}:${internalPort}"
      ];
      volumes = [
        "/mnt/zpr0/apps/otterwiki:/app-data"
      ];
      environments = {
        PUID = "101000";
        PGID = "101000";
      };
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."wiki.${secrets.publicDomain}".extraConfig = ''
    reverse_proxy localhost:${externalPort} {
      header_up Host {http.request.host}
      header_up X-Forwarded-Proto {scheme}
      header_up X-Real-IP {remote_host}
    }
  '';
}
