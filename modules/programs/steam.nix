{pkgs, ...}: {
  programs.steam = {
    enable = true;
    # extraCompatPackages = with pkgs; [
    #   proton-ge-bin
    # ];
    #
    # remotePlay.openFirewall = true;
    # protontricks.enable = true;
  };

  # environment.systemPackages = with pkgs; [
  #   gamescope
  #   gamemode
  # ];
}
