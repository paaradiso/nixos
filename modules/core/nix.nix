{
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
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
}
