{ config, pkgs, lib, ... }:

{

  programs.home-manager.enable = true;

  home.username = "alpha";
  home.homeDirectory = "/home/alpha";

  home.stateVersion = "24.05"; 

  imports = [
    ./dconf.nix
    ./packages.nix
    ./programs.nix
    ./file.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  stylix.enable = true;
}
