{
  description = "nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix/release-24.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };
  outputs = inputs@{ nixpkgs, home-manager, nix-flatpak, stylix, nixos-hardware, ... }: let
    mkNixosSystem = { host, extraModules ? [] }: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        (./hosts + "/${host}/configuration.nix")
        nix-flatpak.nixosModules.nix-flatpak
        stylix.nixosModules.stylix 
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.alpha = import home/alpha/home.nix;
        }
      ] ++ extraModules;
    };
  in {
    nixosConfigurations.utopia    = mkNixosSystem { host = "utopia";    extraModules = [ nixos-hardware.nixosModules.dell-xps-13-9360 ]; };
    nixosConfigurations.phosphene = mkNixosSystem { host = "phosphene"; extraModules = [ nixos-hardware.nixosModules.lenovo-thinkpad-t490s ]; };
  };
}
