{
  config,
  secrets,
  ...
}: let
  inherit (config.virtualisation.quadlet) networks;
  internalPort = "8080";
  externalPort = "8083";
in {
  virtualisation.quadlet.containers.scrutiny = {
    containerConfig = {
      image = "ghcr.io/analogj/scrutiny:master-omnibus";
      autoUpdate = "registry";
      publishPorts = ["${externalPort}:${internalPort}"];
      volumes = [
        "/run/udev:/run/udev:ro"
        "/mnt/zpr0/apps/scrutiny/config:/opt/scrutiny/config"
        "/mnt/zpr0/apps/scrutiny/influxdb:/opt/scrutiny/influxdb"
        "/mnt/zpr0/apps/scrutiny/smartmontools/drivedb.h:/usr/share/smartmontools/drivedb.h:ro"
        "/mnt/zpr0/apps/scrutiny/smartmontools/drivedb.h:/var/lib/smartmontools/drivedb.h:ro"
        "/mnt/zpr0/apps/scrutiny/smartmontools/smartctl:/usr/sbin/smartctl:ro"
        "/mnt/zpr0/apps/scrutiny/smartmontools/smartctl:/usr/local/sbin/smartctl:ro"
        "/mnt/zpr0/apps/scrutiny/smartmontools/smartd:/usr/sbin/smartd:ro"
        "/mnt/zpr0/apps/scrutiny/smartmontools/smartd:/usr/local/sbin/smartd:ro"
        "/mnt/zpr0/apps/scrutiny/smartmontools/update-smart-drivedb:/usr/sbin/update-smart-drivedb:ro"
        "/mnt/zpr0/apps/scrutiny/smartmontools/update-smart-drivedb:/usr/local/sbin/update-smart-drivedb:ro"
      ];
      devices = ["/dev/disk/by-id/wwn-0x5000cca264f77812" "/dev/disk/by-id/wwn-0x5000cca290c7ea87" "/dev/disk/by-id/wwn-0x5000cca2a3cc27c3" "/dev/disk/by-id/wwn-0x5000cca290c2d579"];
      addCapabilities = ["SYS_RAWIO"];
      # environments = {
      #   COLLECTOR_COMMANDS_METRICS_SCAN_ARGS = "-xv 188,raw16 --scan --json -n standby";
      #   COLLECTOR_COMMANDS_METRICS_INFO_ARGS = "-xv 188,raw16 --info --json -n standby";
      #   COLLECTOR_COMMANDS_METRICS_SMART_ARGS = "-xv 188,raw16 --xall --json -n standby";
      # };
      networks = [networks.internal.ref];
    };
    unitConfig = {
      After = "authelia.service";
    };
  };
  services.caddy.virtualHosts."scrutiny.lan.${secrets.domain}".extraConfig = ''
    import private
    reverse_proxy localhost:8083
  '';
}
