{
  config,
  secrets,
  pkgs,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "9898";
  externalPort = internalPort;
in {
  age.secrets.rclone_b2_config.file = ../../../modules/secrets/rclone_b2_config.age;

  virtualisation.quadlet.containers.backrest = {
    containerConfig = {
      image = "docker.io/garethgeorge/backrest:latest";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/backrest/data:/data"
        "/mnt/zpr0/apps/backrest/config:/config"
        "/mnt/zpr0/apps/backrest/cache:/cache"
        "/mnt/zpr0:/userdata"
        "/mnt/b2:/b2"
      ];
      environments = {
        BACKREST_DATA = "/data";
        BACKREST_CONFIG = "/config/config.json";
        XDG_CACHE_HOME = "/cache";
        TZ = "Australia/Adelaide";
      };
      networks = [networks.internal.ref];
    };
  };

  services.caddy.virtualHosts."backrest.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';

  environment.systemPackages = with pkgs; [
    rclone
  ];

  environment.etc."rclone_b2.conf".source = config.age.secrets.rclone_b2_config.path;
  fileSystems."/mnt/b2" = {
    device = "b2:/${secrets.b2_bucket}";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "config=/etc/rclone_b2.conf"
    ];
  };
}
