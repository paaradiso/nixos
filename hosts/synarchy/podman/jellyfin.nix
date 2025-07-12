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
      user = "101000:101000";
      addGroups = ["303"];
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/data/apps/data/podman/jellyfin:/config"
        "/data/media:/data/media"
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
  };

  services.caddy.virtualHosts."media.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
  services.caddy.virtualHosts."media.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      intel-vaapi-driver
      intel-media-sdk
      libva-vdpau-driver
      libvdpau-va-gl
      intel-ocl
    ];
  };
}
