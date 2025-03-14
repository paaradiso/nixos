{
  config,
  pkgs,
  user,
  ...
}: let
  scheme = "gruvbox-material-dark-soft";
in {
  stylix = {
    enable = true;
    polarity = "dark";
    image = config.lib.stylix.pixel "base00";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
    targets = {
      # gnome.enable = false;
      # nvf.enable = false;
    };
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
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

  home-manager.users.${user}.stylix = {
    enable = true;
  };
}
