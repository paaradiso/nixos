{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8989";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.sonarr = {
    containerConfig = {
      image = "ghcr.io/home-operations/sonarr:rolling";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/data/apps/data/podman/sonarr:/config"
        "/data/media:/data/media"
      ];
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "bazarr.service prowlarr.service unpackerr.service";
    };
  };
  services.caddy.virtualHosts."sonarr.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
