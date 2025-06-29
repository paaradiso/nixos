{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.qbittorrent = {
    containerConfig = {
      image = "ghcr.io/home-operations/qbittorrent:5.1.1";
      user = "101000:101000";
      publishPorts = ["11666:11666" "11666:11666/udp" "8081:8081"];
      volumes = [
        "/mnt/data/apps/data/podman/qbittorrent-rootless:/config"
        "/mnt/data:/data"
      ];
      networks = [networks.internal.ref];
    };
  };
}
