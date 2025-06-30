{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.radarr = {
    containerConfig = {
      image = "ghcr.io/home-operations/radarr:rolling";
      user = "101000:101000";
      publishPorts = ["7878:7878"];
      volumes = [
        "/mnt/data/apps/data/podman/radarr:/config"
        "/mnt/data/media:/data/media"
      ];
      networks = [networks.internal.ref];
    };
  };
}
