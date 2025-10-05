{pkgs, ...}: {
  imports = [
    ./gnome.nix
  ];

  environment.systemPackages = with pkgs; [
    corefonts
    vistafonts
    wl-clipboard
    mission-center
  ];
}
