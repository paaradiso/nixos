{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "5055";
  externalPort = internalPort;
in {
  age.secrets.podman_jellyseerr_env.file = ../../../modules/secrets/podman_jellyseerr_env.age;

  virtualisation.quadlet.containers.jellyseerr = {
    containerConfig = {
      image = "docker.io/fallenbagel/jellyseerr:latest";
      autoUpdate = "registry";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/jellyseerr:/app/config"
      ];
      environments = {
        LOG_LEVEL = "debug";
        TZ = "Australia/Adelaide";
        Port = internalPort;
        DB_TYPE = "postgres";
        DB_HOST = "postgresql";
        DB_USER = "jellyseerr_user";
        DB_NAME = "jellyseerr_db";
      };
      environmentFiles = [config.age.secrets.podman_jellyseerr_env.path];
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "jellyfin.service postgresql.service";
    };
  };
  services.caddy.virtualHosts."request.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
  services.caddy.virtualHosts."request.${secrets.publicDomain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
