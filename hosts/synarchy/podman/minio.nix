{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  apiInternalPort = "9000";
  apiExternalPort = apiInternalPort;
  consoleInternalPort = "9001";
  consoleExternalPort = consoleInternalPort;
in {
  age.secrets.podman_minio_env.file = ../../../modules/secrets/podman_minio_env.age;

  virtualisation.quadlet.containers.minio = {
    containerConfig = {
      image = "docker.io/minio/minio:RELEASE.2025-04-22T22-12-26Z";
      exec = "server /data --console-address ':${consoleInternalPort}'";
      publishPorts = ["${apiExternalPort}:${apiInternalPort}" "${consoleExternalPort}:${consoleInternalPort}"];
      # user = "101000:101000";
      volumes = [
        "/data/apps/data/podman/minio:/data"
      ];
      environments = {
        MINIO_ROOT_USER = "admin";
      };
      environmentFiles = [config.age.secrets.podman_minio_env.path];
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "lldap.service";
    };
  };

  services.caddy.virtualHosts."minio.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${apiExternalPort}
  '';
  services.caddy.virtualHosts."minio.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${apiExternalPort}
  '';
  services.caddy.virtualHosts."minio_console.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${consoleExternalPort}
  '';
  services.caddy.virtualHosts."minio_console.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${consoleExternalPort}
  '';
}
