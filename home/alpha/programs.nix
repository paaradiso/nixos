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
        ls = "eza -la";
        cd = "z";
        rb = "sudo nixos-rebuild switch";
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
  };
}
