{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  age.secrets.podman_postgresql_env.file = ../../../modules/secrets/podman_postgresql_env.age;

  virtualisation.quadlet.containers.postgresql = {
    containerConfig = {
      image = "docker.io/tensorchord/pgvecto-rs:pg16-v0.3.0";
      publishPorts = ["5432:5432"];
      volumes = [
        "/mnt/data/apps/data/podman/postgresql:/var/lib/postgresql/data"
      ];
      environments = {
        PUID = "101000";
        PGID = "101000";
        POSTGRES_USER = "postgres";
        POSTGRES_DB = "postgres";
      };
      uidMaps = [
        "0:0:1"
        "1:1:998"
        "999:101000:1"
        "1000:1999:64536"
      ];
      gidMaps = [
        "0:0:1"
        "1:1:998"
        "999:101000:1"
        "1000:1999:64536"
      ];
      environmentFiles = [config.age.secrets.podman_postgresql_env.path];
      networks = [networks.internal.ref];
    };
  };
}
