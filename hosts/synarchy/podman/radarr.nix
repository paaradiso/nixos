{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "7878";
  externalPort = "7878";
in {
  virtualisation.quadlet.containers.radarr = {
    containerConfig = {
      image = "ghcr.io/home-operations/radarr:rolling";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/data/apps/data/podman/radarr:/config"
        "/mnt/data/media:/data/media"
      ];
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."radarr.lan.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
