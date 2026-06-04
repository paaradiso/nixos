{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  age.secrets.podman_redis_env.file = ../../../modules/secrets/podman_redis_env.age;

  virtualisation.quadlet.containers.redis = {
    containerConfig = {
      image = "docker.io/library/redis:7-alpine";
      autoUpdate = "registry";
      user = "101000:101000";
      publishPorts = ["6379:6379"];
      exec = "redis-server /etc/redis/redis.conf";
      volumes = [
        "/mnt/zpr0/apps/redis/redis.conf:/etc/redis/redis.conf"
        "/mnt/zpr0/apps/redis/data:/data"
      ];
      environments = {
        REDIS_AOF_ENABLED = "no";
      };
      environmentFiles = [config.age.secrets.podman_redis_env.path];
      networks = [networks.internal.ref];
    };
  };
}
