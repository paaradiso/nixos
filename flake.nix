{
  description = "nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix/release-24.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nixcord.url = "github:kaylorben/nixcord";
  };
  outputs = inputs@{ nixpkgs, home-manager, nix-flatpak, stylix, nixos-hardware, agenix, ... }: let
    lib = nixpkgs.lib;

    user = "alpha"; ### IF YOU CHANGE THIS, ALSO CHANGE THE ZFS DATASET NAME AND MOUNTPOINT!

    commonModules = [
      ./modules/packages
      ./modules/flatpak
      ./modules/theme
      ./modules/core
      ./modules/secrets
      ./modules/desktop/gnome.nix
      agenix.nixosModules.default 
      stylix.nixosModules.stylix
      nix-flatpak.nixosModules.nix-flatpak
    ];

    mkNixosSystem = { 
      host, 
      system ? "x86_64-linux",
      extraModules ? [] 
    }: lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs host user; };
      modules = [
        (./hosts + "/${host}")
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = ./home;
          home-manager.sharedModules = [
            inputs.nixcord.homeManagerModules.nixcord
          ];
          home-manager.extraSpecialArgs = { inherit user; };
        }
      ] ++ commonModules ++ extraModules;
    };
  in {
    nixosConfigurations.utopia    = mkNixosSystem { host = "utopia";    extraModules = [ nixos-hardware.nixosModules.dell-xps-13-9360 ]; };
    nixosConfigurations.phosphene = mkNixosSystem { host = "phosphene"; extraModules = [ nixos-hardware.nixosModules.lenovo-thinkpad-t490s ]; };
    nixosConfigurations.dearth    = mkNixosSystem { host = "dearth"; };
  };
}
