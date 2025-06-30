{
  imports = [
    ./audiobookrequest.nix
    ./bazarr.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix
    ./unpackerr.nix

    ./qbittorrent.nix

    ./open-webui.nix
    ./tika.nix

    ./immich.nix

    ./redis.nix

    ./authelia.nix
    ./vaultwarden.nix
  ];

  virtualisation.quadlet = {
    autoUpdate.enable = true;
    networks.internal = {
    };
  };
}
