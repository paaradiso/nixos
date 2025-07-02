{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8091";
  externalPort = internalPort;
in {
  age.secrets.podman_vaultwarden_env.file = ../../../modules/secrets/podman_vaultwarden_env.age;

  virtualisation.quadlet.containers.vaultwarden = {
    containerConfig = {
      image = "docker.io/vaultwarden/server:latest";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/data/apps/data/podman/vaultwarden:/data"
      ];
      environments = {
        ROCKET_PORT = internalPort;
      };
      environmentFiles = [config.age.secrets.podman_vaultwarden_env.path];
      networks = [networks.internal.ref];
    };
  };

  services.caddy.virtualHosts."vault.${secrets.domain}".extraConfig = ''
    handle /admin* {
      respond 403
    }
    handle {
      reverse_proxy localhost:${externalPort}
    }
  '';
  services.caddy.virtualHosts."vault.lan.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
