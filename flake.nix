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
    nixcord.url = "github:kaylorben/nixcord";
  };
  outputs = inputs@{ nixpkgs, home-manager, nix-flatpak, stylix, nixos-hardware, ... }: let

    lib = nixpkgs.lib;

    commonModules = [
      ./modules/packages
      ./modules/flatpak
      ./modules/theme
      ./modules/core
      ./modules/desktop/gnome.nix
      stylix.nixosModules.stylix
      nix-flatpak.nixosModules.nix-flatpak
    ];

    mkHome = users: lib.listToAttrs (map (user: {
      name = user;
      value = import (./home + "/${user}/home.nix");
    }) users);

    mkNixosSystem = { 
      host, 
      users ? [ "alpha" ],
      system ? "x86_64-linux",
      extraModules ? [] 
    }: lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs host; };
      modules = [
        (./hosts + "/${host}/configuration.nix")
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users = mkHome users;
          home-manager.sharedModules = [
            inputs.nixcord.homeManagerModules.nixcord
          ];
        }
      ] ++ commonModules ++ extraModules;
    };
  in {
    nixosConfigurations.utopia    = mkNixosSystem { host = "utopia";    extraModules = [ nixos-hardware.nixosModules.dell-xps-13-9360 ]; };
    nixosConfigurations.phosphene = mkNixosSystem { host = "phosphene"; extraModules = [ nixos-hardware.nixosModules.lenovo-thinkpad-t490s ]; };
    nixosConfigurations.dearth    = mkNixosSystem { host = "dearth"; };
  };
}
