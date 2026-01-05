{
  config,
  pkgs,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8096";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.jellyfin = {
    containerConfig = {
      image = "docker.io/jellyfin/jellyfin:latest";
      autoUpdate = "registry";
      user = "101000:101000";
      addGroups = ["303"];
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/jellyfin:/config"
        "/mnt/zpr0/media:/data/media"
      ];
      devices = ["/dev/dri"];
      shmSize = "32G";
      environments = {
        JELLYFIN_DATA_DIR = "/config/data";
        JELLYFIN_CONFIG_DIR = "/config";
        JELLYFIN_LOG_DIR = "/config/log";
        JELLYFIN_CACHE_DIR = "/config/cache";
      };
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "lldap.service";
    };
  };

  services.caddy.virtualHosts."media.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
  services.caddy.virtualHosts."media.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
  services.caddy.virtualHosts."media.${secrets.publicDomain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];
  };
}
