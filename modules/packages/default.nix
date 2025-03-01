{ pkgs, inputs, ... }:

{
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
    zed-editor
    bitwarden
    zsh
    zoxide
    bat
    eza
    jellyfin-media-player
    inputs.zen-browser.packages."${system}".default
    helix
    ghostty
    feishin
    teams-for-linux
  ];
}
