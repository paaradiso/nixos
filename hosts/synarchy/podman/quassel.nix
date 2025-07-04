{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "4242";
  externalPort = "4242";
in {
  age.secrets.podman_quassel_env.file = ../../../modules/secrets/podman_quassel_env.age;

  virtualisation.quadlet.containers.quassel = {
    containerConfig = {
      image = "docker.io/linuxserver/quassel-core:0.14.0";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/data/apps/data/podman/quassel:/config"
      ];
      environments = {
        PUID = "101000";
        PGID = "101000";
        TZ = "Australia/Adelaide";
        DB_BACKEND = "PostgreSQL";
        DB_PGSQL_USERNAME = "quassel_user";
        DB_PGSQL_DATABASE = "quassel_db";
        DB_PGSQL_HOSTNAME = "postgresql";
        DB_PGSQL_PORT = "5432";
        AUTH_AUTHENTICATOR = "LDAP";
        AUTH_LDAP_HOSTNAME = "lldap";
        AUTH_LDAP_PORT = "3890";
        AUTH_LDAP_UID_ATTRIBUTE = "uid";
        # RUN_OPTS = "--config-from-environment";
      };
      environmentFiles = [config.age.secrets.podman_quassel_env.path];
      networks = [networks.internal.ref];
    };
  };
}
