{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.lldap = {
    containerConfig = {
      image = "docker.io/lldap/lldap:stable";
      publishPorts = ["3890:3890"];
      volumes = [
        "/mnt/data/apps/data/podman/lldap:/data"
      ];
      environments = {
        UID = "101000";
        GID = "101000";
        TZ = "Australia/Adelaide";
      };
      networks = [networks.internal.ref];
    };
  };
}
