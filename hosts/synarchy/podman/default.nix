{config, ...}: {
  imports = [
    ./audiobookrequest.nix
    ./open-webui.nix
    ./qbittorrent.nix
    ./tika.nix
    ./vaultwarden.nix
  ];

  config.virtualisation.quadlet = {
    autoUpdate.enable = true;
    networks.internal = {
    };
  };
}
