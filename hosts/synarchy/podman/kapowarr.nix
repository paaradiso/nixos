{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "5656";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.kapowarr = {
    containerConfig = {
      image = "docker.io/mrcas/kapowarr:latest";
      autoUpdate = "registry";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/kapowarr/db:/app/db"
        "/mnt/zpr0/media:/data/media"
      ];
      environments = {
        PUID = "101000";
        PGID = "101000";
      };
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "prowlarr.service";
    };
  };
  services.caddy.virtualHosts."kapowarr.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
