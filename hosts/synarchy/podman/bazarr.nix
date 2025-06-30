{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.bazarr = {
    containerConfig = {
      image = "ghcr.io/home-operations/bazarr:rolling";
      user = "101000:101000";
      publishPorts = ["6767:6767"];
      volumes = [
        "/mnt/data/apps/data/podman/bazarr:/config"
        "/mnt/data/media:/data/media"
      ];
      networks = [networks.internal.ref];
    };
  };
}
