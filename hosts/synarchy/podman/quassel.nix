{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "4242";
  externalPort = "4242";
in {
  age.secrets.podman_quassel_env.file = ../../../modules/secrets/podman_quassel_env.age;

  virtualisation.quadlet.containers.quassel = {
    containerConfig = {
      image = "registry.gitlab.com/kalaksi-containers/quassel:latest";
      autoUpdate = "registry";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/quassel:/opt/quassel/config"
      ];
      exec = [
        "--config-from-environment"
      ];
      environments = {
        DB_BACKEND = "PostgreSQL";
        DB_PGSQL_USERNAME = "quassel_user";
        DB_PGSQL_HOSTNAME = "postgresql";
        DB_PGSQL_PORT = "5432";
        DB_PGSQL_DATABASE = "quassel_db";
        AUTH_AUTHENTICATOR = "LDAP";
        AUTH_LDAP_HOSTNAME = "ldap://lldap";
        AUTH_LDAP_PORT = "3890";
      };
      environmentFiles = [config.age.secrets.podman_quassel_env.path];
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "lldap.service";
    };
  };
}
