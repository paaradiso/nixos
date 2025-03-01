{ pkgs, user, ... }:

{
  stylix = {
    enable = true;
    polarity = "dark";
    image = ../../assets/161616.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
    targets = {
      # gnome.enable = false;
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

  home-manager.users.${user}.stylix.enable = true;
}
