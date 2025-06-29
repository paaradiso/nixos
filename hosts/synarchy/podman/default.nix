{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./audiobookrequest.nix
    # ./open-webui.nix
    ./qbittorrent.nix
    ./vaultwarden.nix
  ];

  config.virtualisation.quadlet = {
    autoUpdate.enable = true;
    networks.internal = {
    };
  };
}
