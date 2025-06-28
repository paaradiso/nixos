{
  host,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/system/virtualisation.nix
    ../../modules/audio/easyeffects/flat.nix
    ../../modules/programs/steam.nix
    ../../modules/programs/cs-toggle-res.nix
    ../../modules/misc/webcam.nix
  ];

  boot.initrd.luks.devices = {
    cryptkey = {
      device = "/dev/disk/by-uuid/4280abbf-0b71-4311-a8a5-d3b885d275a6";
    };
    cryptswap = {
      device = "/dev/disk/by-uuid/1b6679d0-cdb8-4886-b82c-b7b1b4ea6f4d";
      keyFileSize = 8192;
      keyFile = "/dev/mapper/cryptkey";
      allowDiscards = true;
    };
    cryptroot = {
      device = "/dev/disk/by-uuid/63b33eb5-01fb-42ca-af0b-b71c954f02e9";
      keyFileSize = 8192;
      keyFile = "/dev/mapper/cryptkey";
      allowDiscards = true;
    };
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];
  boot.kernelParams = ["module_blacklist=i915"];
  programs.corectrl.enable = true;

  networking.hostName = host;
  networking.hostId = "fafafafa";

  services.flatpak.packages = ["sh.ppy.osu"];
  boot.blacklistedKernelModules = ["wacom"];
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = false;
  };

  environment.systemPackages = with pkgs; [
    mprime
    phoronix-test-suite
    stressapptest
    hpl
  ];

  programs.corefreq.enable = true;
}
