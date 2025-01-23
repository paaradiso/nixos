{ config, pkgs, lib, ... }:

{

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alpha";
  home.homeDirectory = "/home/alpha";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.hot-edge
    gnomeExtensions.just-perfection
    gnomeExtensions.rounded-window-corners-reborn

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/alpha/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

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
          "just-perfection-desktop@just-perfection"
          "rounded-window-corners-reborn@fxgn"
        ];
      };
      "org/gnome/shell/extensions/just-perfection" = {
        keyboard-layout = false;
        quick-settings-dark-mode = false;
        screen-sharing-indicator = false;
        window-demands-attention-focus = true;
        switcher-popup-delay = false;
      };
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


  programs = {
    git = {
      enable = true;
      userName = "paaradiso";
      userEmail = "paaradiso@swag.horse";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ls = "eza -la";
        cd = "z";
      };
      initExtra = ''
        autoload -Uz vcs_info
        precmd() { vcs_info }
	zstyle ':vcs_info:git:*' formats '%b '
	setopt PROMPT_SUBST
	PROMPT='%F{blue}%~%f %F{red}''${vcs_info_msg_0_}%f$ '
      '';
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
