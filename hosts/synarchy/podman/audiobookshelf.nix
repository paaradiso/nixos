{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "4000";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.audiobookshelf = {
    containerConfig = {
      image = "ghcr.io/advplyr/audiobookshelf:latest";
      publishPorts = ["${externalPort}:${internalPort}"];
      user = "101000:101000";
      volumes = [
        "/mnt/zpr0/apps/audiobookshelf/config:/usr/share/audiobookshelf/config"
        "/mnt/zpr0/apps/audiobookshelf/metadata:/usr/share/audiobookshelf/metadata"
        "/mnt/zpr0/media/library:/data/media/library"
      ];
      environments = {
        PORT = internalPort;
        HOST = "0.0.0.0";
        CONFIG_PATH = "/usr/share/audiobookshelf/config";
        METADATA_PATH = "/usr/share/audiobookshelf/metadata";
      };
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "authelia.service";
    };
  };

  services.caddy.virtualHosts."abs.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
