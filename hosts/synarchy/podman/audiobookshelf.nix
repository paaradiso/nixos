{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.audiobookshelf = {
    containerConfig = {
      image = "ghcr.io/advplyr/audiobookshelf:latest";
      publishPorts = ["4000:4000"];
      user = "101000:101000";
      volumes = [
        "/mnt/data/apps/data/podman/audiobookshelf/config:/usr/share/audiobookshelf/config"
        "/mnt/data/apps/data/podman/audiobookshelf/metadata:/usr/share/audiobookshelf/metadata"
        "/mnt/data/media/library:/data/media/library"
      ];
      environments = {
        PORT = "4000";
        HOST = "0.0.0.0";
        CONFIG_PATH = "/usr/share/audiobookshelf/config";
        METADATA_PATH = "/usr/share/audiobookshelf/metadata";
      };
      networks = [networks.internal.ref];
    };
  };
}
