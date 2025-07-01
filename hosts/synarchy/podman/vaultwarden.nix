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

  services.caddy.wildcardServices.vaultwarden = ''
    @vault host vault.${secrets.domain}
    handle @vault {
      handle /admin* {
        respond 403
      }
      handle {
        reverse_proxy localhost:${externalPort}
      }
    }
  '';
  services.caddy.wildcardLanServices.vaultwarden = ''
    @vault host vault.lan.${secrets.domain}
    handle @vault {
      reverse_proxy localhost:${externalPort}
    }
  '';
}
