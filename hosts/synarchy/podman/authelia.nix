{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.authelia = {
    containerConfig = {
      image = "docker.io/authelia/authelia:latest";
      publishPorts = ["9091:9091"];
      volumes = [
        "/mnt/data/apps/data/podman/authelia:/config"
      ];
      environments = {
        PUID = "101000";
        PGID = "101000";
      };
      networks = [networks.internal.ref];
    };
  };
}
