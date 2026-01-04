{
  host,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/system/virtualisation.nix
    ../../modules/audio/easyeffects/flat.nix
    # ../../modules/programs/steam.nix
    ../../modules/programs/cs-toggle-res.nix
    ../../modules/misc/webcam.nix
    ../../modules/misc/elecom_huge.nix
    # ../../modules/desktop/niri.nix
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

  services.flatpak.packages = ["sh.ppy.osu" "com.valvesoftware.Steam" "com.valvesoftware.Steam.CompatibilityTool.Proton-GE"];
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
    prismlauncher
    darktable
    rpcs3
    mednafen
    (pkgs.writeShellScriptBin "fix-audio" ''
      echo "Resetting ASMedia USB Controller..."
      echo "1" | sudo tee /sys/bus/pci/devices/0000:04:00.0/remove
      sleep 1
      echo "1" | sudo tee /sys/bus/pci/rescan
      echo "Done."
    '')
  ];

  services.udev.extraRules = ''
    # Disable autosuspend for ASMedia ASM3241 USB Controller to prevent audio output loss
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1b21", ATTR{device}=="0x3241", ATTR{power/control}="on"
  '';

  programs.corefreq.enable = true;

  system.stateVersion = "24.11";
}
