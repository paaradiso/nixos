{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8080";
  externalPort = "8082";
in {
  age.secrets.podman_immich_env.file = ../../../modules/secrets/podman_immich_env.age;

  virtualisation.quadlet.containers.immich = {
    containerConfig = {
      image = "ghcr.io/imagegenius/immich:latest";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/immich/photos:/photos"
        "/mnt/zpr0/apps/immich/config:/config"
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
    unitConfig = {
      After = "authelia.service";
    };
  };
  services.caddy.virtualHosts."immich.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
  services.caddy.virtualHosts."immich.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
