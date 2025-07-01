# home/programs.nix
{
  pkgs,
  config,
  ...
}: {
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
        rb = "sudo --preserve-env=SSH_AUTH_SOCK nixos-rebuild switch";
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
    bat.enable = true;
    nix-index.enable = true;
    nix-index.enableZshIntegration = true;
    nix-index-database.comma.enable = true;
  };
}
