{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./audiobookrequest.nix
  ];

  config.virtualisation.quadlet = {
    autoUpdate.enable = true;
    networks.internal = {
    };
  };
}
