{
  imports = [
    ./bazarr.nix
    ./seerr.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix
    ./unpackerr.nix
    ./wrtag.nix
    ./slskd.nix
    ./shelfmark.nix
    # ./kapowarr.nix

    ./qbittorrent.nix

    ./open-webui.nix
    ./tika.nix

    ./audiobookshelf.nix
    ./immich.nix
    ./jellyfin.nix
    ./navidrome.nix
    ./outline.nix
    ./quassel.nix
    ./stalwart.nix
    ./copyparty.nix

    ./minio.nix
    ./postgresql.nix
    ./redis.nix

    ./authelia.nix
    ./lldap.nix
    ./vaultwarden.nix

    ./backrest.nix
    # ./grafito.nix
    # ./scrutiny.nix

    ./monero.nix

    ./amp.nix
  ];

  virtualisation.quadlet = {
    autoUpdate.enable = true;
    autoEscape = true;
    networks.internal = {
    };
  };
}
