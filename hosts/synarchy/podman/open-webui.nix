{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8080";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.open-webui = {
    containerConfig = {
      image = "ghcr.io/open-webui/open-webui:ollama";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/data/apps/data/podman/open-webui:/app/backend/data"
        "/data/apps/data/podman/ollama:/root/.ollama"
      ];
      environments = {
        UID = "101000";
        GID = "101000";
        BYPASS_MODEL_ACCESS_CONTROL = "true";
      };
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."ai.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
  services.caddy.virtualHosts."ai.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
