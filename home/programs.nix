# home/programs.nix
{
  pkgs,
  config,
  ...
}: let
  discordStylixCss = pkgs.replaceVars ./../files/discord-system24-template.css {
    base00 = config.lib.stylix.colors.base00;
    base01 = config.lib.stylix.colors.base01;
    base02 = config.lib.stylix.colors.base02;
    base03 = config.lib.stylix.colors.base03;
    # base04 = config.lib.stylix.colors.base04;
    base05 = config.lib.stylix.colors.base05;
    base06 = config.lib.stylix.colors.base06;
    # base07 = config.lib.stylix.colors.base07;
    base08 = config.lib.stylix.colors.base08;
    base09 = config.lib.stylix.colors.base09;
    base0A = config.lib.stylix.colors.base0A;
    base0B = config.lib.stylix.colors.base0B;
    base0C = config.lib.stylix.colors.base0C;
    base0D = config.lib.stylix.colors.base0D;
    base0E = config.lib.stylix.colors.base0E;
    # base0F = config.lib.stylix.colors.base0F;
  };
in {
  programs = {
    git = {
      enable = true;
      userName = "paaradiso";
      userEmail = "38374917+paaradiso@users.noreply.github.com";
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
        ls = "eza -la --group";
        cd = "z";
        rb = "sudo nixos-rebuild switch";
        lg = "lazygit";
      };
      initContent = ''
        autoload -Uz vcs_info
        precmd() {
          vcs_info
          if [[ -n "$IN_NIX_SHELL" ]]; then
            NIX_SHELL_INDICATOR="λ "
          else
            NIX_SHELL_INDICATOR=""
          fi
          PROMPT='%F{blue}%~%f %F{red}''${vcs_info_msg_0_}%f%F{magenta}''${NIX_SHELL_INDICATOR}%f$ '
        }
        zstyle ':vcs_info:git:*' formats '%b '
        setopt PROMPT_SUBST
        eval "$(direnv hook zsh)"
      '';
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    helix.enable = true;
    ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        window-padding-x = 12;
        window-padding-y = 12;
      };
    };
    bat.enable = true;

    nixcord = {
      enable = true;
      quickCss = builtins.readFile discordStylixCss;
      config = {
        useQuickCss = true;
      };
      discord.autoscroll.enable = true;
    };
    nix-index.enable = true;
    nix-index.enableZshIntegration = true;
    nix-index-database.comma.enable = true;
  };
}
