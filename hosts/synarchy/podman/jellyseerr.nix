{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  age.secrets.podman_jellyseerr_env.file = ../../../modules/secrets/podman_jellyseerr_env.age;

  virtualisation.quadlet.containers.jellyseerr = {
    containerConfig = {
      image = "docker.io/fallenbagel/jellyseerr:latest";
      user = "101000:101000";
      publishPorts = ["5055:5055"];
      volumes = [
        "/mnt/data/apps/data/podman/jellyseerr:/app/config"
      ];
      environments = {
        LOG_LEVEL = "debug";
        TZ = "Australia/Adelaide";
        Port = "5055";
        DB_TYPE = "postgres";
        DB_HOST = "postgresql";
        DB_USER = "jellyseerr_user";
        DB_NAME = "jellyseerr_db";
      };
      environmentFiles = [config.age.secrets.podman_jellyseerr_env.path];
      networks = [networks.internal.ref];
    };
  };
}
