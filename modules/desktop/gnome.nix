{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    gnome-tour
    gnome-text-editor
    gnome-music
    # totem # videos
    cheese # webcam
    epiphany # browser
    geary # email
    gnome-characters
    gnome-maps
    gnome-contacts
    simple-scan
    gnome-user-docs
    gnome-system-monitor
    yelp
  ];

  environment.systemPackages = with pkgs; [
    corefonts
    vistafonts
    wl-clipboard
    mission-center
    gnome-monitor-config
  ];

  home-manager.users.${user} = {
    home.packages = with pkgs; [
      gnomeExtensions.blur-my-shell
      gnomeExtensions.caffeine
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.hot-edge
      gnomeExtensions.just-perfection
      gnomeExtensions.rounded-window-corners-reborn
      gnomeExtensions.grand-theft-focus
      gnomeExtensions.status-icons
    ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "blur-my-shell@aunetx"
            "caffeine@patapon.info"
            "clipboard-indicator@tudmotu.com"
            "hotedge@jonathan.jdoda.ca"
            "no-switcher-delay@illegal.charity"
            "rounded-window-corners@fxgn"
            "status-icons@gnome-shell-extensions.gcampax.github.com"
            "grand-theft-focus@zalckos.github.com"
          ];
          favorite-apps = [
            "com.mitchellh.ghostty.desktop"
            "org.gnome.Nautilus.desktop"
            "zen-beta.desktop"
            "steam.desktop"
            "discord.desktop"
            "com.spotify.Client.desktop"
          ];
        };
        "org/gnome/mutter" = {edge-tiling = true;};
        "org/gnome/desktop/interface" = {
          show-battery-percentage = true;
          enable-animations = false;
          gtk-enable-primary-paste = false;
        };
        "org/gnome/desktop/wm/keybindings" = {
          switch-windows = ["<Alt>Tab"];
          switch-windows-backward = ["<Shift><Alt>Tab"];
          switch-applications = [];
          switch-applications-backward = [];
          toggle-fullscreen = ["<Super>f"];
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
        };
        "org/gnome/desktop/peripherals/touchpad" = {natural-scroll = false;};
        "org/gnome/desktop/peripherals/mouse" = {accel-profile = "flat";};
      };
    };

    home.file = {
      ".local/share/gnome-shell/extensions/no-switcher-delay@illegal.charity" = {
        source = ../../files + "/no-switcher-delay@illegal.charity";
        recursive = true;
      };
    };
  };
}
