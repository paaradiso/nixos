{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "7878";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.radarr = {
    containerConfig = {
      image = "ghcr.io/home-operations/radarr:rolling";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/data/apps/data/podman/radarr:/config"
        "/data/media:/data/media"
      ];
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "bazarr.service prowlarr.service unpackerr.service";
    };
  };
  services.caddy.virtualHosts."radarr.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
