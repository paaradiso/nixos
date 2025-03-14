{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  programs.home-manager.enable = true;

  home.username = user;
  home.homeDirectory = "/home/${user}";

  imports = [
    ./programs.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.file.".profile".text = ''
    export MOZ_ENABLE_WAYLAND=0
  ''; # it's bugged

  home.stateVersion = "24.05";
}
