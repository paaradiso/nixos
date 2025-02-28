{ pkgs, inputs, ... }:

{
  imports = [
    ./xmousepasteblock.nix
  ];

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
    xmousepasteblock
  ];
}
