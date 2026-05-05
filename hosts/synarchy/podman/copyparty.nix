{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "3923";
  externalPort = internalPort;
in {
  virtualisation.quadlet.containers.copyparty = {
    containerConfig = {
      image = "docker.io/copyparty/ac:latest";
      autoUpdate = "registry";
      user = "101000:101000";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/mnt/zpr0/apps/copyparty:/cfg"
        "/mnt/zpr0/media:/w"
      ];
      environments = {
        LD_PRELOAD = "/usr/lib/libmimalloc-secure.so.NOPE";
      };
      networks = [networks.internal.ref];
    };
  };

  services.caddy.virtualHosts."copyparty.${secrets.publicDomain}".extraConfig = ''
    reverse_proxy localhost:${externalPort}
  '';
}
