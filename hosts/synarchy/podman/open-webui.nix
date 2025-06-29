{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
  port = "8080";
in {
  virtualisation.quadlet.containers.open-webui = {
    containerConfig = {
      image = "ghcr.io/open-webui/open-webui:ollama";
      publishPorts = ["${port}:${port}"];
      user = "101000:101000";
      volumes = [
        "/mnt/data/apps/data/podman/open-webui:/app/backend/data"
        "/mnt/data/apps/data/podman/ollama:/root/.ollama"
      ];
      environments = {
        # UID = "101000";
        # GID = "101000";
        BYPASS_MODEL_ACCESS_CONTROL = "true";
      };
      networks = [networks.internal.ref];
    };
  };
}
