{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.xmousepasteblock ];

  systemd.user.services.xmousepasteblock = {
    enable = true;
    wantedBy = [ "graphical-session.target" ];
    description = "XmousePasteBlock - Userspace tool to disable middle mouse button paste in Xorg";
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.xmousepasteblock}/bin/xmousepasteblock'';
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
