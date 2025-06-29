{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nix.nix
    ./boot.nix
    ./users.nix
    ./direnv.nix
    ./zfs.nix
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };
  console.keyMap = "us";
  time.timeZone = "Australia/Adelaide";
  nixpkgs.config.allowUnfree = true;
}
