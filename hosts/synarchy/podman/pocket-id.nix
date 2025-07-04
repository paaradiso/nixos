{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "1411";
  externalPort = internalPort;
in {
  age.secrets.podman_pocket-id_env.file = ../../../modules/secrets/podman_pocket-id_env.age;

  virtualisation.quadlet.containers.pocket-id = {
    containerConfig = {
      image = "ghcr.io/pocket-id/pocket-id:latest";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/data/apps/data/podman/pocket-id:/app/data"
      ];
      environments = {
        PUID = "101000";
        PGID = "101000";
        PORT = internalPort;
        APP_URL = "https://id.${secrets.domain}";
        DB_PROVIDER = "postgres";
        TRUST_PROXY = "true";
      };
      environmentFiles = [config.age.secrets.podman_pocket-id_env.path];
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."id.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
