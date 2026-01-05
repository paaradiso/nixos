{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "4533";
  externalPort = internalPort;
in {
  age.secrets.podman_navidrome_env.file = ../../../modules/secrets/podman_navidrome_env.age;

  virtualisation.quadlet.containers.navidrome = {
    containerConfig = {
      image = "ghcr.io/joestump/navidrome-ldap:develop";
      autoUpdate = "registry";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/navidrome:/data"
        "/mnt/zpr0/media/library/music:/music:ro"
      ];
      user = "101000:101000";
      environments = {
        ND_LDAP_HOST = "ldap://lldap:3890";
        ND_LDAP_NAME = "cn";
        ND_LDAP_MAIL = "mail";
      };
      environmentFiles = [config.age.secrets.podman_navidrome_env.path];
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "lldap.service";
    };
  };
  services.caddy.virtualHosts."music.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
