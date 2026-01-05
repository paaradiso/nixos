{pkgs, ...}: {
  imports = [
    ./gnome.nix
  ];

  environment.systemPackages = with pkgs; [
    corefonts
    vista-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    wl-clipboard
    mission-center
  ];
}
