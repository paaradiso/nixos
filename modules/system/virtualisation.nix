{
  config,
  pkgs,
  user,
  ...
}: {
  boot.kernelParams = ["intel_iommu=on"];

  users.users.${user}.extraGroups = ["libvirtd" "qemu-libvirtd"];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice

    looking-glass-client
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  # systemd.tmpfiles.rules = [
  #   "f /dev/shm/looking-glass 0660 ${user} qemu-libvirtd -"
  # ];

  # https://blog.redstone.engineer/posts/nixos-windows-guest-simple-looking-glass-setup-guide/
  boot.extraModulePackages = [config.boot.kernelPackages.kvmfr];
  boot.kernelModules = ["kvmfr"];
  boot.extraModprobeConfig = ''
    options kvmfr static_size_mb=32
  '';
  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="${user}", GROUP="kvm", MODE="0660"
  '';
  virtualisation.libvirtd.qemu.verbatimConfig = ''
    cgroup_controllers = [ "cpu", "memory", "blkio", "cpuset", "cpuacct" ]
  '';
}
