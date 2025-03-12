{
  config,
  pkgs,
  user,
  ...
}: {
  # Define users
  users.users.${user} = {
    isNormalUser = true;
    home = "/home/${user}";
    createHome = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };

  # Enable zsh
  programs.zsh.enable = true;
}
