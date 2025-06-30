{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  age.secrets.podman_redis_env.file = ../../../modules/secrets/podman_redis_env.age;

  virtualisation.quadlet.containers.redis = {
    containerConfig = {
      image = "docker.io/bitnami/redis:latest";
      user = "101000:101000";
      publishPorts = ["6379:6379"];
      volumes = [
        "/mnt/data/apps/data/podman/redis/redis.conf:/etc/redis/redis.conf"
        "/mnt/data/apps/data/podman/redis/data:/var/lib/redis"
      ];
      environments = {
        REDIS_AOF_ENABLED = "no";
      };
      environmentFiles = [config.age.secrets.podman_redis_env.path];
      networks = [networks.internal.ref];
    };
  };
}
