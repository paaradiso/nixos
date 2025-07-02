{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "9696";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.prowlarr = {
    containerConfig = {
      image = "ghcr.io/home-operations/prowlarr:rolling";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/data/apps/data/podman/prowlarr:/config"
      ];
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."prowlarr.lan.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
