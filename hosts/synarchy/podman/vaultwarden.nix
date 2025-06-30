{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
  port = "8091";
in {
  age.secrets.podman_vaultwarden_env.file = ../../../modules/secrets/podman_vaultwarden_env.age;

  virtualisation.quadlet.containers.vaultwarden = {
    containerConfig = {
      image = "docker.io/vaultwarden/server:latest";
      user = "101000:101000";
      publishPorts = ["${port}:${port}"];
      volumes = [
        "/mnt/data/apps/data/podman/vaultwarden:/data"
      ];
      environments = {
        ROCKET_PORT = port;
      };
      environmentFiles = [config.age.secrets.podman_vaultwarden_env.path];
      networks = [networks.internal.ref];
    };
  };
}
