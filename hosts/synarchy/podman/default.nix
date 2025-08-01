{
  imports = [
    ./bazarr.nix
    ./jellyseerr.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix
    ./unpackerr.nix
    ./wrtag.nix

    ./qbittorrent.nix

    ./open-webui.nix
    ./tika.nix

    ./audiobookshelf.nix
    ./immich.nix
    ./jellyfin.nix
    ./outline.nix
    ./quassel.nix
    ./stalwart.nix

    ./minio.nix
    ./postgresql.nix
    ./redis.nix

    ./authelia.nix
    ./lldap.nix
    ./vaultwarden.nix

    ./backrest.nix
    ./scrutiny.nix
  ];

  virtualisation.quadlet = {
    autoUpdate.enable = true;
    autoEscape = true;
    networks.internal = {
    };
  };
}
