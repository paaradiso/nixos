{ ... }: 

{
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
        ls = "eza -la --group";
        cd = "z";
        rb = "sudo nixos-rebuild switch";
      };
      initExtra = ''
        autoload -Uz vcs_info
        precmd() { 
          vcs_info
          # Dynamically update NIX_SHELL_PROMPT before each command
          if [[ -n "$IN_NIX_SHELL" ]]; then
            NIX_SHELL_PROMPT="❆ "
          else
            NIX_SHELL_PROMPT=""
          fi
          PROMPT='%F{blue}%~%f %F{red}''${vcs_info_msg_0_}%f''${NIX_SHELL_PROMPT}$ '
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
    };
  };
}
