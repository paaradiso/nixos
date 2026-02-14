{
  pkgs,
  user,
  ...
}: let
  homeDir =
    if pkgs.stdenv.isDarwin
    then "/Users/${user}"
    else "/home/${user}";
  userGroup =
    if pkgs.stdenv.isDarwin
    then "staff"
    else "users";
in {
  age.identityPaths = [
    "${homeDir}/.ssh/id_ed25519"
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  age.secrets = {
    git_key = {
      file = ./git_key.age;
      path = "${homeDir}/.ssh/git_key";
      symlink = false;
      mode = "600";
      owner = user;
      group = userGroup;
    };
  };
}
