{ pkgs, user, ... }:

{
  imports = [
    ./flat.nix
  ];

  home-manager.users.${user} = {
    services.easyeffects.enable = true;
    home.file.".config/easyeffects/output/akg_k371_brainwavz_oval.json".source = ./akg_k371_brainwavz_oval.json;
  };
}
