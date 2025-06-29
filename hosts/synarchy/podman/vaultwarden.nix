{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  port = "8091";
in {
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
