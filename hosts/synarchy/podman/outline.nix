{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "3000";
  externalPort = internalPort;
  domain = "outline.${secrets.domain}";
  oidcUriBase = "https://auth.${secrets.domain}";
in {
  age.secrets.podman_outline_env.file = ../../../modules/secrets/podman_outline_env.age;

  virtualisation.quadlet.containers.outline = {
    containerConfig = {
      image = "docker.io/outlinewiki/outline:latest";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/outline:/var/lib/outline/data"
      ];
      environments = {
        URL = "https://${domain}";
        PORT = internalPort;
        PGSSLMODE = "disable";
        FILE_STORAGE = "local";
        OIDC_CLIENT_ID = "outline";
        OIDC_AUTH_URI = "${oidcUriBase}/api/oidc/authorization";
        OIDC_TOKEN_URI = "${oidcUriBase}/api/oidc/token";
        OIDC_USERINFO_URI = "${oidcUriBase}/api/oidc/userinfo";
        OIDC_LOGOUT_URI = "${oidcUriBase}/application/o/outline/end-session/";
        OIDC_USERNAME_CLAIM = "preferred_username";
        OIDC_DISPLAY_NAME = "OpenID Connect";
      };
      environmentFiles = [config.age.secrets.podman_outline_env.path];
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "authelia.service";
    };
  };
  services.caddy.virtualHosts.${domain}.extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
