{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user} = {
    services.easyeffects.enable = true;
    home.file.".config/easyeffects/output/flat.json".source = ./flat.json;
  };
}
