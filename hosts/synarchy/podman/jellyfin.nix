{
  config,
  pkgs,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.jellyfin = {
    containerConfig = {
      image = "docker.io/jellyfin/jellyfin:latest";
      user = "101000:101000";
      addGroups = ["303"];
      publishPorts = ["8096:8096"];
      volumes = [
        "/mnt/data/apps/data/podman/jellyfin:/config"
        "/mnt/data/media:/data/media"
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

  hardware.opengl = {
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
