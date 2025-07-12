{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "17170";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.lldap = {
    containerConfig = {
      image = "docker.io/lldap/lldap:stable";
      publishPorts = ["3890:3890" "${externalPort}:${internalPort}"];
      volumes = [
        "/data/apps/data/podman/lldap:/data"
      ];
      environments = {
        UID = "101000";
        GID = "101000";
        TZ = "Australia/Adelaide";
      };
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."ldap.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
