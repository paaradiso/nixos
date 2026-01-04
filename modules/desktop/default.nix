{pkgs, ...}: {
  imports = [
    ./gnome.nix
  ];

  environment.systemPackages = with pkgs; [
    corefonts
    vista-fonts
    wl-clipboard
    mission-center
  ];
}
