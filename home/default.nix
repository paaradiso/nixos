{user, ...}: {
  programs.home-manager.enable = true;

  home.username = user;
  home.homeDirectory = "/home/${user}";

  imports = [
    ./programs.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.stateVersion = "24.05";
}
