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
  };
}
