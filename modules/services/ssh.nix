{
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  systemd.user.services.add_git_key = {
    script = ''
      ssh-add $HOME/.ssh/git_key
    '';
    wantedBy = ["multi-user.target"];
  };
}
