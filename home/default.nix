{user, pkgs, ...}: {
  programs.home-manager.enable = true;

  home.username = user;
  home.homeDirectory = 
    if pkgs.stdenv.isDarwin 
    then "/Users/${user}"
    else "/home/${user}";

  imports = [
    ./programs.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.stateVersion = "24.05";
}
