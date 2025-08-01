{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "6767";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.bazarr = {
    containerConfig = {
      image = "ghcr.io/home-operations/bazarr:rolling";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/bazarr:/config"
        "/mnt/zpr0/media:/data/media"
      ];
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "postgresql.service";
    };
  };
  services.caddy.virtualHosts."bazarr.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
