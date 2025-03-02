{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    initrd.systemd.enable = true; # Required for plymouth to show password prompt for LUKS
    plymouth = {
      enable = true;
    };
    consoleLogLevel = 0;
    kernelParams = [ 
      "quiet" 
      "splash" 
      "boot.shell_on_fail" 
      "loglevel=3" 
      "rd.systemd.show_status=false" 
      "rd.udev.log_level=3" 
      "udev.log_priority=3" 
    ];
};
}
