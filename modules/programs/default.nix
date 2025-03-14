{
  imports = [
    ./nvf.nix
  ];

  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "0"; # zen is bugged and it needs this
}
