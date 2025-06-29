{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.audiobookrequest = {
    containerConfig = {
      image = "docker.io/markbeep/audiobookrequest:latest";
      user = "101000:101000";
      publishPorts = ["8000:8000"];
      volumes = [
        "/mnt/data/apps/data/podman/audiobookrequest:/config"
      ];
      networks = [networks.internal.ref];
    };
  };
}
