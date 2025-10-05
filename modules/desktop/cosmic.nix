{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  services = {
    xserver = {
      enable = true;
    };
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
  };
}
