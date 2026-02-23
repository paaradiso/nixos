{
  description = "nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    secrets.url = "git+ssh://git@github.com/paaradiso/nixos-secrets.git?ref=main";
    nvf = {
      url = "github:notashelf/nvf/d5da1a14c3895be269653d47b320697b1d2dafae";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix/release-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixcord.url = "github:KaylorBen/nixcord";
    niri.url = "github:sodiboo/niri-flake";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quadlet-nix.url = "github:SEIAROTg/quadlet-nix";
    helium.url = "github:FKouhai/helium2nix/main";
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nix-darwin,
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
      ./modules/secrets
      ./modules/theme
      ./modules/core/nix.nix
      ./modules/core/direnv.nix
    ];

    nixosModules =
      [
        ./modules/core
        ./modules/services
        ./modules/desktop
        agenix.nixosModules.default
        nvf.nixosModules.default
        stylix.nixosModules.stylix
      ]
      ++ commonModules;

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
        specialArgs = {
          inherit system inputs host user;
          secrets = inputs.secrets.config;
        };
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
              home-manager.extraSpecialArgs = {
                inherit user;
                secrets = inputs.secrets.config;
              };
              home-manager.backupFileExtension = "backup";
            }
          ]
          ++ nixosModules
          ++ lib.optionals personalSystem [
            ./modules/packages/personal-system.nix
            ./modules/flatpak
            ./modules/programs
            ./modules/desktop
            nix-flatpak.nixosModules.nix-flatpak
          ];
      };
  in {
    formatter.x86_64-linux = inputs.alejandra.defaultPackage.x86_64-linux;
    formatter.aarch64-darwin = inputs.alejandra.packages.aarch64-darwin.alejandra-arm64-apple-darwin;

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

    darwinConfigurations.aldrlok = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {
        inherit inputs user;
        secrets = inputs.secrets.config;
        host = "aldrlok";
      };
      modules =
        [
          ./hosts/aldrlok
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = ./home;
            home-manager.sharedModules = [inputs.nvf.homeManagerModules.default ./modules/programs/nvf] ++ hmSharedModules ++ hmPersonalSystemSharedModules;
            home-manager.extraSpecialArgs = {
              inherit user;
              secrets = inputs.secrets.config;
            };
            home-manager.backupFileExtension = "backup";
          }
          agenix.darwinModules.default
          stylix.darwinModules.stylix
        ]
        ++ commonModules;
    };
  };
}
