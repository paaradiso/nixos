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
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quadlet-nix.url = "github:SEIAROTg/quadlet-nix";
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
      ./modules/core
      ./modules/secrets
      ./modules/services
      ./modules/packages
      agenix.nixosModules.default
      nvf.nixosModules.default
      stylix.nixosModules.stylix
    ];

    personalSystemCommonModules = [
      ./modules/packages/personal-system.nix
      ./modules/flatpak
      ./modules/theme
      ./modules/programs
      ./modules/desktop/gnome.nix
      nix-flatpak.nixosModules.nix-flatpak
    ];

    hmSharedModules = [
      nix-index-database.hmModules.nix-index
    ];

    hmPersonalSystemSharedModules = [
      inputs.nixcord.homeModules.nixcord
    ];

    mkNixosSystem = {
      host,
      system ? "x86_64-linux",
      personalSystem ? true,
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
              home-manager.users.${user} =
                if personalSystem
                then ./home
                else ./hosts + "/${host}/home";
              home-manager.sharedModules = hmSharedModules ++ lib.optionals personalSystem hmPersonalSystemSharedModules;
              home-manager.extraSpecialArgs = {inherit user;};
              home-manager.backupFileExtension = "backup";
            }
          ]
          ++ commonModules
          ++ lib.optionals personalSystem personalSystemCommonModules;
      };
  in {
    formatter.x86_64-linux = inputs.alejandra.defaultPackage.x86_64-linux;

    nixosConfigurations.utopia = mkNixosSystem {
      host = "utopia";
    };
    nixosConfigurations.phosphene = mkNixosSystem {
      host = "phosphene";
    };
    nixosConfigurations.dearth = mkNixosSystem {host = "dearth";};
    nixosConfigurations.synarchy = mkNixosSystem {
      host = "synarchy";
      personalSystem = false;
    };
  };
}
