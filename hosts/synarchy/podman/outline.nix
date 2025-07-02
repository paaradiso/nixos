{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "3000";
  externalPort = internalPort;
in {
  age.secrets.podman_outline_env.file = ../../../modules/secrets/podman_outline_env.age;

  virtualisation.quadlet.containers.outline = {
    containerConfig = {
      image = "docker.io/outlinewiki/outline:latest";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/data/apps/data/podman/outline:/var/lib/outline/data"
      ];
      environments = {
        PORT = internalPort;
        PGSSLMODE = "disable";
        FILE_STORAGE = "local";
        OIDC_CLIENT_ID = "outline";
        OIDC_USERNAME_CLAIM = "preferred_username";
        OIDC_DISPLAY_NAME = "OpenID Connect";
        OIDC_SCOPES = "openid email profile";
      };
      environmentFiles = [config.age.secrets.podman_outline_env.path];
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."outline.${secrets.domain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
