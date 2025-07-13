{user, ...}: {
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  systemd.user.services.add_git_key = {
    description = "Add Git SSH key to agent";
    wantedBy = ["default.target"];
    after = ["ssh-agent.service"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/ssh-add /home/${user}/.ssh/git_key";
      Environment = "SSH_AUTH_SOCK=%t/ssh-agent";
    };
  };
}
