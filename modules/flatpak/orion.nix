{ pkgs, ... }: {
  services.flatpak.packages = [
    rec {
      appId = "com.kagi.OrionGtk";
      sha256 = "17prs1kpig2bdbiz01abc0mwh2gx4zqjajl0hn3fcgpj4g8s8zbd";
      bundle = "${pkgs.fetchurl {
        url = "https://orionbrowser.com/download/oriongtk-early-beta";
        inherit sha256;
      }}";
    }
  ];
}
