# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  boot.initrd.luks.devices = {
    cryptkey = {
      device = "/dev/disk/by-uuid/c86fe0e7-8cff-4433-9895-722f4d96f59e";
    };
    cryptswap = {
      device = "/dev/disk/by-uuid/22553d23-f6b2-4fc6-a867-150e309bf93d";
      keyFileSize = 8192;
      keyFile = "/dev/mapper/cryptkey";
    };
    cryptroot = {
      device = "/dev/disk/by-uuid/f2bb6ab7-1c39-4dfe-b687-6852d7940c6e";
      keyFileSize = 8192;
      keyFile = "/dev/mapper/cryptkey";
      allowDiscards = true;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.systemd.enable = true; # Required for plymouth to show password prompt for LUKS
  boot.plymouth = {
    enable = true;
  };
  boot.consoleLogLevel = 0;
  boot.kernelParams = ["quiet" "splash" "boot.shell_on_fail" "loglevel=3" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3"];
  boot.loader.timeout = 0;

  networking.hostName = "utopia"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Australia/Adelaide";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  console.keyMap = "us";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.xkb.options = "ctrl:nocaps";

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    gnome-tour
    gnome-text-editor
    gnome-music
    totem # videos
    cheese # webcam
    epiphany # browser
    geary # email
    gnome-characters
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "gtk";
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alpha = {
    isNormalUser = true;
    home = "/home/alpha";
    createHome = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
  };
  users.defaultUserShell = pkgs.zsh;

  # programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    tree
    gnome-tweaks
    wget
    htop
    ncdu
    git
    lazygit
    zed-editor
    bitwarden
    zsh
    zoxide
    bat
    eza
    jellyfin-media-player
    vesktop
    inputs.zen-browser.packages."${system}".default
    helix
    ghostty
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "com.spotify.Client"
      "org.quassel_irc.QuasselClient"
    ];
  };

  stylix = {
    enable = true;
    polarity = "dark";
    image = ../../assets/161616.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
    targets = {
      # gnome.enable = false;
    };
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
    };
    fonts = {
      monospace = {
        package = pkgs.iosevka-comfy.comfy-motion-fixed;
        name = "Iosevka Comfy Motion Fixed";
      };
      sansSerif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };
      sizes = {
        terminal = 12;
      };
    };
  };

  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.hostId = "3ae53d5e";

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
