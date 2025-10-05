{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  UiInternalPort = "5030";
  UiExternalPort = UiInternalPort;
  slskdInternalPort = "50300";
  slskdExternalPort = slskdInternalPort;
in {
  virtualisation.quadlet.containers.slskd = {
    containerConfig = {
      image = "docker.io/slskd/slskd:latest";
      autoUpdate = "registry";
      user = "101000:101000";
      publishPorts = ["${UiExternalPort}:${UiInternalPort}" "${slskdExternalPort}:${slskdInternalPort}"];
      volumes = [
        "/mnt/zpr0/apps/slskd:/app"
        "/mnt/zpr0/media:/data/media"
        "/mnt/zpr0/media/slskd/downloads:/downloads"
        "/mnt/zpr0/media/slskd/incomplete:/incomplete"
      ];
      environments = {
        SLSKD_REMOTE_CONFIGURATION = "true";
      };
      networks = [networks.internal.ref];
    };
  };
  services.caddy.virtualHosts."slskd.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${UiExternalPort}
  '';
}
