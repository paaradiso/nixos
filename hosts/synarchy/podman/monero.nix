{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "18081";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.monero = {
    containerConfig = {
      image = "docker.io/cornfeedhobo/monero:latest";
      autoUpdate = "registry";
      publishPorts = ["${externalPort}:${internalPort}"];
      user = "101000:101000";
      volumes = [
        "/mnt/zpr0/apps/monero:/home/monero/.bitmonero"
      ];
      networks = [networks.internal.ref];
    };
  };
}
