{ ... }:

{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        # `gnome-extensions list` for a list of installed extensions
        enabled-extensions = [
          "blur-my-shell@aunetx"
          "caffeine@patapon.info"
          "clipboard-indicator@tudmotu.com"
          "hotedge@jonathan.jdoda.ca"
          # "just-perfection-desktop@just-perfection"
          "no-switcher-delay@illegal.charity"
          "rounded-window-corners@fxgn"
          # "pop-shell@system76.com"
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
      # "org/gnome/shell/extensions/just-perfection" = {
      #   keyboard-layout = false;
      #   quick-settings-dark-mode = false;
      #   screen-sharing-indicator = false;
      #   window-demands-attention-focus = true;
      #   switcher-popup-delay = false;
      # };
      # "org/gnome/shell/pop-shell" = {
      #   tile-by-default = false;       
      # };
      "org/gnome/mutter" = {
        edge-tiling = true; # false is required for pop-shell/tile-by-default
      };
      "org/gnome/desktop/interface" = {
        # monospace-font-name = "Iosevka Comfy Motion Fixed 11";
        # cursor-theme = "phinger-cursors-dark";
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
      "org/gnome/desktop/peripherals/touchpad" = {
        natural-scroll = false;
      };
      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
      };
    };
  };
}
