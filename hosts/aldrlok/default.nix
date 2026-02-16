{
  pkgs,
  user,
  host,
  ...
}: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "vesktop"
      "orion"
      "alt-tab"
      "vanilla"
    ];
  };

  environment.systemPackages = with pkgs; [
    raycast
    maccy
    spotify
    coconutbattery
    bitwarden-desktop
  ];

  networking.hostName = host;
  networking.computerName = host;

  users.users.${user}.home = "/Users/${user}";

  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = user;

  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
  };

  time.timeZone = "Australia/Adelaide";
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
