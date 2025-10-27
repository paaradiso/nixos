{
  pkgs,
  inputs,
  user,
  ...
}: {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "8192";
    }
  ];

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  environment.systemPackages = with pkgs; [
    fuzzel
    mako
    waybar
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    alacritty
    swaybg
    swayidle
    swaylock
    xwayland-satellite
    wofi
    foot
    kitty # Added kitty as it is used in binds
    swaynotificationcenter # Added swaync-client
    cliphist # Added cliphist
    brillo # Added brillo
    playerctl # Added playerctl
  ];

  programs.niri.enable = true;

  home-manager.users.${user} = {config, ...}: {
    programs.niri = {
      settings = {
        spawn-at-startup = [
          {argv = ["niriswitcher"];}
        ];
        binds = with config.lib.niri.actions; {
          # "Alt+Tab".action = spawn "gdbus" "call" "--session" "--dest" "io.github.isaksamsten.Niriswitcher" "--object-path" "/io/github/isaksamsten/Niriswitcher" "--method" "io.github.isaksamsten.Niriswitcher.application";
          # "Alt+Tab".repeat = false;
          # "Alt+Shift+Tab".action = spawn "gdbus" "call" "--session" "--dest" "io.github.isaksamsten.Niriswitcher" "--object-path" "/io/github/isaksamsten/Niriswitcher" "--method" "io.github.isaksamsten.Niriswitcher.application";
          # "Alt+Shift+Tab".repeat = false;
          "Mod+Shift+Slash".action = show-hotkey-overlay;
          "Mod+Escape".action = toggle-overview;
          "Mod+Return".action = spawn "ghostty";
          "Mod+R".action = spawn "wofi" "--show" "drun";
          # "Mod+L".action = spawn "swaylock";
          "Mod+A".action = spawn "swaync-client" "-t" "-sw";
          "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
          "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
          "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          "Shift+XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "0.1+";
          "Shift+XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "0.1-";
          "Shift+XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          "XF86AudioPlay".action = spawn "playerctl" "play-pause";
          "XF86MonBrightnessDown".action = spawn "brillo" "-q" "-U" "5";
          "XF86MonBrightnessUp".action = spawn "brillo" "-q" "-A" "5";
          "Mod+Q".action = close-window;
          "Mod+Left".action = focus-column-left;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;
          "Mod+Right".action = focus-column-right;
          "Mod+H".action = focus-column-left;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;
          "Mod+L".action = focus-column-right;
          "Mod+Ctrl+Left".action = move-column-left;
          "Mod+Ctrl+Down".action = move-window-down;
          "Mod+Ctrl+Up".action = move-window-up;
          "Mod+Ctrl+Right".action = move-column-right;
          "Mod+Ctrl+H".action = move-column-left;
          "Mod+Ctrl+J".action = move-window-down;
          "Mod+Ctrl+K".action = move-window-up;
          "Mod+Ctrl+L".action = move-column-right;
          "Mod+Home".action = focus-column-first;
          "Mod+End".action = focus-column-last;
          "Mod+Ctrl+Home".action = move-column-to-first;
          "Mod+Ctrl+End".action = move-column-to-last;
          "Mod+Shift+Left".action = focus-monitor-left;
          "Mod+Shift+Down".action = focus-monitor-down;
          "Mod+Shift+Up".action = focus-monitor-up;
          "Mod+Shift+Right".action = focus-monitor-right;
          "Mod+Shift+H".action = focus-monitor-left;
          "Mod+Shift+J".action = focus-monitor-down;
          "Mod+Shift+K".action = focus-monitor-up;
          "Mod+Shift+L".action = focus-monitor-right;
          "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
          "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
          "Mod+Page_Down".action = focus-workspace-down;
          "Mod+Page_Up".action = focus-workspace-up;
          "Mod+U".action = focus-workspace-down;
          "Mod+I".action = focus-workspace-up;
          "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
          "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
          "Mod+Ctrl+U".action = move-column-to-workspace-down;
          "Mod+Ctrl+I".action = move-column-to-workspace-up;
          "Mod+Shift+Page_Down".action = move-workspace-down;
          "Mod+Shift+Page_Up".action = move-workspace-up;
          "Mod+Shift+U".action = move-workspace-down;
          "Mod+Shift+I".action = move-workspace-up;
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
          "Mod+Ctrl+1".action = move-column-to-index 1;
          "Mod+Ctrl+2".action = move-column-to-index 2;
          "Mod+Ctrl+3".action = move-column-to-index 3;
          "Mod+Ctrl+4".action = move-column-to-index 4;
          "Mod+Ctrl+5".action = move-column-to-index 5;
          "Mod+Ctrl+6".action = move-column-to-index 6;
          "Mod+Ctrl+7".action = move-column-to-index 7;
          "Mod+Ctrl+8".action = move-column-to-index 8;
          "Mod+Ctrl+9".action = move-column-to-index 9;
          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;
          # "Mod+R".action = switch-preset-column-width;
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+C".action = center-column;
          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";
          # "Print".action = screenshot;
          # "Ctrl+Print".action = screenshot-screen;
          # "Alt+Print".action = screenshot-window;
          "Mod+Shift+E".action = quit;
          "Mod+Shift+P".action = power-off-monitors;
          "Mod+Shift+Ctrl+T".action = toggle-debug-tint;
        };
      };
    };
  };
}
