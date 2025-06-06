{
  description = "nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixcord.url = "github:KaylorBen/nixcord";
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nix-flatpak,
    stylix,
    nixos-hardware,
    agenix,
    nvf,
    nix-index-database,
    ...
  }: let
    inherit (nixpkgs) lib;

    user = "alpha"; ### IF YOU CHANGE THIS, ALSO CHANGE THE ZFS DATASET NAME AND MOUNTPOINT!

    commonModules = [
      ./modules/packages
      ./modules/flatpak
      ./modules/theme
      ./modules/core
      ./modules/secrets
      ./modules/programs
      ./modules/desktop/gnome.nix
      nix-flatpak.nixosModules.nix-flatpak
      agenix.nixosModules.default
      stylix.nixosModules.stylix
      nvf.nixosModules.default
    ];

    mkNixosSystem = {
      host,
      system ? "x86_64-linux",
      extraModules ? [],
    }:
      lib.nixosSystem {
        inherit system;
        specialArgs = {inherit system inputs host user;};
        modules =
          [
            (./hosts + "/${host}")
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = ./home;
              home-manager.sharedModules = [
                inputs.nixcord.homeModules.nixcord
                nix-index-database.hmModules.nix-index
              ];
              home-manager.extraSpecialArgs = {inherit user;};
              home-manager.backupFileExtension = "backup";
            }
          ]
          ++ commonModules
          ++ extraModules;
      };
  in {
    formatter.x86_64-linux = inputs.alejandra.defaultPackage.x86_64-linux;

    nixosConfigurations.utopia = mkNixosSystem {
      host = "utopia";
      extraModules = [nixos-hardware.nixosModules.dell-xps-13-9360];
    };
    nixosConfigurations.phosphene = mkNixosSystem {
      host = "phosphene";
      extraModules = [nixos-hardware.nixosModules.lenovo-thinkpad-t490s];
    };
    nixosConfigurations.dearth = mkNixosSystem {host = "dearth";};
  };
}
