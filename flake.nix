{
  description = "my nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.utopia = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
