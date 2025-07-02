{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8989";
  externalPort = "8989";
in {
  virtualisation.quadlet.containers.sonarr = {
    containerConfig = {
      image = "ghcr.io/home-operations/sonarr:rolling";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/data/apps/data/podman/sonarr:/config"
        "/mnt/data/media:/data/media"
      ];
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."sonarr.lan.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
