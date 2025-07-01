{
  imports = [
    ./bazarr.nix
    ./jellyseerr.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix
    ./unpackerr.nix

    ./qbittorrent.nix

    ./open-webui.nix
    ./tika.nix

    ./jellyfin.nix
    ./audiobookshelf.nix
    ./immich.nix
    ./outline.nix

    ./postgresql.nix
    ./redis.nix

    ./authelia.nix
    ./lldap.nix
    ./vaultwarden.nix
  ];

  virtualisation.quadlet = {
    autoUpdate.enable = true;
    networks.internal = {
    };
  };
}
