{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  consoleInternalPort = "8080";
  consoleExternalPort = "8079";
  smtpInternalPort = "25";
  smtpExternalPort = smtpInternalPort;
  smtpsInternalPort = "587";
  smtpsExternalPort = smtpsInternalPort;
  imapsInternalPort = "993";
  imapsExternalPort = imapsInternalPort;
in {
  virtualisation.quadlet.containers.stalwart = {
    containerConfig = {
      image = "docker.io/stalwartlabs/stalwart:latest";
      autoUpdate = "registry";
      publishPorts = [
        "${consoleExternalPort}:${consoleInternalPort}"
        "${smtpExternalPort}:${smtpInternalPort}"
        "${smtpsExternalPort}:${smtpsInternalPort}"
        "${imapsExternalPort}:${imapsInternalPort}"
      ];
      volumes = [
        "/mnt/zpr0/apps/stalwart:/opt/stalwart"
      ];
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "lldap.service";
    };
  };
  services.caddy.virtualHosts."stalwart.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:${consoleExternalPort}
  '';
}
