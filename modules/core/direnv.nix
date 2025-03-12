{user, ...}: {
  home-manager.users.${user}.programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
