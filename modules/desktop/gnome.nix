{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-console
    gnome-tour
    gnome-text-editor
    gnome-music
    totem # videos
    cheese # webcam
    epiphany # browser
    geary # email
    gnome-characters
  ]);

  # xdg.portal = {
  #   enable = true;
  #   xdgOpenUsePortal = true;
  #   config.common.default = "gtk";
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };
}
