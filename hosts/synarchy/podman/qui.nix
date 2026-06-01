{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "7476";
  externalPort = internalPort;
in {
  age.secrets.podman_qui_env.file = ../../../modules/secrets/podman_qui_env.age;

  virtualisation.quadlet.containers.qui = {
    containerConfig = {
      image = "ghcr.io/autobrr/qui:latest";
      autoUpdate = "registry";
      user = "101000:101000";
      publishPorts = [
        "${externalPort}:${internalPort}"
      ];
      volumes = [
        "/mnt/zpr0/apps/qui:/config"
      ];
      environments = {
        QUI__DATABASE_ENGINE = "postgres";
      };
      environmentFiles = [config.age.secrets.podman_qui_env.path];
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "postgresql.service";
    };
  };
  services.caddy.virtualHosts."qui.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
