{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.sonarr = {
    containerConfig = {
      image = "ghcr.io/home-operations/sonarr:rolling";
      user = "101000:101000";
      publishPorts = ["8989:8989"];
      volumes = [
        "/mnt/data/apps/data/podman/sonarr:/config"
        "/mnt/data/media:/data/media"
      ];
      networks = [networks.internal.ref];
    };
  };
}
