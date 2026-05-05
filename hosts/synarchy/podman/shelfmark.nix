{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8084";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.shelfmark = {
    containerConfig = {
      image = "ghcr.io/calibrain/shelfmark:latest";
      autoUpdate = "registry";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/shelfmark:/config"
        "/mnt/zpr0/media/downloads/audiobooks:/downloads/audiobooks"
        "/mnt/zpr0/media/library/audiobooks:/library/audiobooks"
      ];
      environments = {
        PUID = "101000";
        PGID = "101000";
        TZ = "Australia/Adelaide";
      };
      networks = [networks.internal.ref];
    };
  };

  services.caddy.virtualHosts."shelfmark.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
  services.caddy.virtualHosts."shelfmark.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
