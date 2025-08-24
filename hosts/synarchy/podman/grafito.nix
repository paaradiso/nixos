{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "3000";
  externalPort = "3009";
in {
  virtualisation.quadlet.containers.grafito = {
    containerConfig = {
      image = "ghcr.io/ralsina/grafito:latest";
      # user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/var/log/journal:/var/log/journal"
      ];
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."grafito.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
