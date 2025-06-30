{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.jellyfin = {
    containerConfig = {
      image = "docker.io/jellyfin/jellyfin:latest";
      user = "101000:101000";
      publishPorts = ["8096:8096"];
      volumes = [
        "/mnt/data/apps/data/podman/jellyfin:/config"
      ];
      devices = ["/dev/dri"];
      shmSize = "32G";
      environments = {
        JELLYFIN_DATA_DIR = "/config/data";
        JELLYFIN_CONFIG_DIR = "/config";
        JELLYFIN_LOG_DIR = "/config/log";
        JELLYFIN_CACHE_DIR = "/config/cache";
      };
      networks = [networks.internal.ref];
    };
  };
}
