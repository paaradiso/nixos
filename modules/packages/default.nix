{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    tree
    wget
    htop
    ncdu
    git
    lazygit
    bitwarden
    zsh
    zoxide
    ripgrep
    eza
    inputs.agenix.packages.${system}.default
    inputs.alejandra.defaultPackage.${system}
  ];
}
