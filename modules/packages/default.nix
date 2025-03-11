{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./xmousepasteblock.nix
  ];

  environment.systemPackages = with pkgs; [
    vim
    tree
    gnome-tweaks
    wget
    htop
    ncdu
    git
    lazygit
    bitwarden
    zsh
    zoxide
    bat
    eza
    jellyfin-media-player
    inputs.zen-browser.packages.${system}.default
    helix
    ghostty
    feishin
    teams-for-linux
    obsidian
    libreoffice-still
    inputs.agenix.packages.${system}.default
    inputs.alejandra.defaultPackage.${system}
  ];
}
