{config, ...}: let
  inherit (config.virtualisation.quadlet) networks;
in {
  virtualisation.quadlet.containers.unpackerr = {
    containerConfig = {
      image = "ghcr.io/unpackerr/unpackerr:latest";
      user = "101000:101000";
      volumes = [
        "/mnt/zpr0/apps/unpackerr:/config"
        "/mnt/zpr0/media:/data/media"
      ];
      environments = {
        TZ = "Australia/Adelaide";
      };
      networks = [networks.internal.ref];
    };
  };
}
