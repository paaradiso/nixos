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
      image = "ghcr.io/home-operations/qbittorrent:rolling";
      user = "101000:101000";
      publishPorts = ["${torrentPort}:${torrentPort}" "${torrentPort}:${torrentPort}/udp" "${externalPort}:${internalPort}"];
      volumes = [
        "/data/apps/data/podman/qbittorrent-rootless:/config"
        "/data:/data"
      ];
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."qbittorrent.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
