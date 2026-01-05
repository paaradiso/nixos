{
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];

      max-jobs = 1;
      cores = 6;
    };

    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
    "qtwebengine-5.15.19"
    "intel-media-sdk-23.2.2"
  ];
}
