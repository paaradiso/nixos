{ config, pkgs, lib, user, ... }:

{

  programs.home-manager.enable = true;

  home.username = user;
  home.homeDirectory = "/home/${user}";

  home.stateVersion = "24.05"; 

  imports = [
  # ./dconf.nix
    ./packages.nix
    ./programs.nix
  # ./file.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  stylix.enable = true;
}
