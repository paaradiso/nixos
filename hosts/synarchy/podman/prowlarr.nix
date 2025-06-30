{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.prowlarr = {
    containerConfig = {
      image = "ghcr.io/home-operations/prowlarr:rolling";
      user = "101000:101000";
      publishPorts = ["9696:9696"];
      volumes = [
        "/mnt/data/apps/data/podman/prowlarr:/config"
      ];
      networks = [networks.internal.ref];
    };
  };
}
