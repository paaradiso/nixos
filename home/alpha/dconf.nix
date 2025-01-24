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
        #  "just-perfection-desktop@just-perfection"
          "no-switcher-delay@illegal.charity"
          "rounded-window-corners@fxgn"
        ];
      };
      # "org/gnome/shell/extensions/just-perfection" = {
      #   keyboard-layout = false;
      #   quick-settings-dark-mode = false;
      #   screen-sharing-indicator = false;
      #   window-demands-attention-focus = true;
      #   switcher-popup-delay = false;
      # };
      "org/gnome/desktop/interface" = {
        # monospace-font-name = "Iosevka Comfy Motion Fixed 11";
        # cursor-theme = "phinger-cursors-dark";
        show-battery-percentage = true;
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        natural-scroll = false;
      };
    };
  };
}
