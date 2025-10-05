{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8080";
  externalPort = "25570";
  mcInternalPort = "25565";
  mcExternalPort = mcInternalPort;
in {
  virtualisation.quadlet.containers.amp = {
    containerConfig = {
      image = "docker.io/mitchtalmadge/amp-dockerized:latest";
      autoUpdate = "registry";
      publishPorts = ["${externalPort}:${internalPort}" "${mcExternalPort}:${mcInternalPort}"];
      volumes = [
        "/mnt/zpr0/apps/amp:/home/amp/.ampdata"
      ];
      environments = {
        UID = "101000";
        GID = "101000";
        TZ = "Australia/Adelaide";
        LICENCE = secrets.amp_key;
        MODULE = "Minecraft";
      };
      podmanArgs = [
        "--mac-address=02:42:0A:0C:E7:44"
      ];
      addCapabilities = [
        "NET_RAW"
      ];
      networks = [networks.internal.ref];
    };
  };

  services.caddy.virtualHosts."amp.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${externalPort}
  '';
}
