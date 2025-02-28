{ config, lib, pkgs, user, ... }:

{
  ### 1. Enable GNOME and Xserver ###
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;
  };

  ### 2. Remove Unwanted GNOME Apps ###
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

  ### 3. Home Manager DConf Settings ###
  home-manager.users.${user} = {
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
            "zen.desktop"
            "discord.desktop"
            "com.spotify.Client.desktop"
          ];
        };
        "org/gnome/mutter" = { edge-tiling = true; };
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
        "org/gnome/desktop/peripherals/touchpad" = { natural-scroll = false; };
        "org/gnome/desktop/peripherals/mouse" = { accel-profile = "flat"; };
      }; 
    };

    ### 4. Copy GNOME Extensions & Electron Flags ###
    home.file = {
      ".local/share/gnome-shell/extensions/no-switcher-delay@illegal.charity" = {
        source = ../../home + "/files/no-switcher-delay@illegal.charity";
        recursive = true;
      };
    };
  };
}

