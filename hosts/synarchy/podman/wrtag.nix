{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8000";
  externalPort = internalPort;
in {
  age.secrets.podman_wrtag_env.file = ../../../modules/secrets/podman_wrtag_env.age;

  virtualisation.quadlet.containers.wrtag = {
    containerConfig = {
      image = "ghcr.io/sentriz/wrtag:latest";
      publishPorts = ["${externalPort}:${internalPort}"];
      user = "101000:101000";
      volumes = [
        "/mnt/zpr0/apps/wrtag:/config"
        "/mnt/zpr0/media:/data/media"
      ];
      environments = {
        WRTAG_WEB_LISTEN_ADDR = ":8000";
        WRTAG_WEB_PUBLIC_URL = "https://wrtag.lan.${secrets.domain}";
        WRTAG_WEB_DB_PATH = "/config/wrtag.db";
        WRTAG_CONFIG_PATH = "/config/wrtag.cfg";
      };
      environmentFiles = [config.age.secrets.podman_wrtag_env.path];
      networks = [networks.internal.ref];
    };
  };

  services.caddy.virtualHosts."wrtag.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
