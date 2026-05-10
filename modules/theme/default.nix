{
  config,
  pkgs,
  user,
  lib,
  ...
}: let
  importYAML = path:
    builtins.fromJSON (
      builtins.readFile (
        pkgs.runCommand "yaml-to-json.json" {nativeBuildInputs = [pkgs.yj];} ''
          ${pkgs.yj}/bin/yj < ${path} > $out
        ''
      )
    );

  scheme = "mountain";
  schemePath = "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
  schemeData = importYAML schemePath;

  detectedPolarity = schemeData.variant or "dark";

  cursorName = "phinger-cursors-${detectedPolarity}";
in {
  stylix = lib.mkMerge [
    {
      enable = true;
      polarity = detectedPolarity;
      image = config.lib.stylix.pixel "base00";

      base16Scheme = schemePath;

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
    }
    (lib.mkIf pkgs.stdenv.isLinux {
      cursor = {
        package = pkgs.phinger-cursors;
        name = cursorName;
        size = 32;
      };
    })
  ];

  home-manager.users.${user}.stylix = {
    enable = true;
    targets = {
      nixcord.enable = false;
    };
  };
}
