{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./xmousepasteblock.nix
  ];

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${system}.default
    inputs.helium.defaultPackage.${system}
    gnome-tweaks
    jellyfin-media-player
    feishin
    obsidian
    libreoffice-still
    kooha
    zotero
    thunderbird
    jetbrains.datagrip
  ];
}
