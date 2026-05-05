{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "5055";
  externalPort = internalPort;
in {
  age.secrets.podman_seerr_env.file = ../../../modules/secrets/podman_seerr_env.age;

  virtualisation.quadlet.containers.seerr = {
    containerConfig = {
      image = "ghcr.io/seerr-team/seerr:latest";
      autoUpdate = "registry";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/seerr:/app/config"
      ];
      environments = {
        LOG_LEVEL = "debug";
        TZ = "Australia/Adelaide";
        Port = internalPort;
        DB_TYPE = "postgres";
        DB_HOST = "postgresql";
        DB_USER = "seerr_user";
        DB_NAME = "seerr_db";
      };
      environmentFiles = [config.age.secrets.podman_seerr_env.path];
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
