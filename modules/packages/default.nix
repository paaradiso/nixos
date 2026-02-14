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
    zsh
    zoxide
    ripgrep
    eza
    (
      if pkgs.stdenv.isDarwin
      then inputs.alejandra.packages.aarch64-darwin.alejandra-arm64-apple-darwin
      else inputs.alejandra.defaultPackage.${system}
    )
    inputs.agenix.packages.${system}.default
  ];
}
