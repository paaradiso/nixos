{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  age.secrets.podman_immich_env.file = ../../../modules/secrets/podman_immich_env.age;

  virtualisation.quadlet.containers.immich = {
    containerConfig = {
      image = "ghcr.io/imagegenius/immich:latest";
      publishPorts = ["8082:8080"];
      volumes = [
        "/mnt/data/apps/data/podman/immich/photos:/photos"
        "/mnt/data/apps/data/podman/immich/config:/config"
      ];
      devices = ["/dev/dri"];
      environments = {
        PUID = "101000";
        PGID = "101000";
        TZ = "Australia/Adelaide";
        DB_HOSTNAME = "postgresql";
        DB_USERNAME = "immich_user";
        DB_DATABASE_NAME = "immich_db";
        REDIS_HOSTNAME = "redis";
      };
      environmentFiles = [config.age.secrets.podman_immich_env.path];
      networks = [networks.internal.ref];
    };
  };
}
