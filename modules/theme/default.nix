{
  config,
  pkgs,
  # user,
  ...
}: let
  scheme = "chalk";
  polarity = "dark";
in {
  stylix = {
    enable = true;
    inherit polarity;
    image = config.lib.stylix.pixel "base00";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 32;
    };
    fonts = {
      monospace = {
        package = pkgs.iosevka-comfy.comfy-motion-fixed;
        name = "Iosevka Comfy Motion Fixed";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      sizes = {
        terminal = 11;
      };
    };
  };

  # home-manager.users.${user}.stylix = {
  #   enable = true;
  # };
}
