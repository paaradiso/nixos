{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8081";
  externalPort = internalPort;
  torrentPort = "11666";
in {
  virtualisation.quadlet.containers.qbittorrent = {
    containerConfig = {
      image = "ghcr.io/home-operations/qbittorrent:5.1.1";
      user = "101000:101000";
      publishPorts = ["${torrentPort}:${torrentPort}" "${torrentPort}:${torrentPort}/udp" "${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/data/apps/data/podman/qbittorrent-rootless:/config"
        "/mnt/data:/data"
      ];
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."qbittorrent.lan.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
