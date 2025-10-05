{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.tika = {
    containerConfig = {
      image = "docker.io/apache/tika:latest";
      autoUpdate = "registry";
      user = "101000:101000";
      networks = [networks.internal.ref];
    };
  };
}
