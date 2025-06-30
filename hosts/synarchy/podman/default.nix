{
  imports = [
    ./audiobookrequest.nix
    ./bazarr.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix

    ./qbittorrent.nix

    ./open-webui.nix
    ./tika.nix

    ./redis.nix

    ./vaultwarden.nix
  ];

  virtualisation.quadlet = {
    autoUpdate.enable = true;
    networks.internal = {
    };
  };
}
