{user, ...}: {
  age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  age.secrets.git_key = {
    file = ./git_key.age;
    path = "/home/${user}/.ssh/git_key";
    symlink = false;
    mode = "600";
    owner = user;
    group = "users";
  };
  age.secrets.home_wg.file = ./home_wg.age;
}
