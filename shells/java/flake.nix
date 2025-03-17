{
  description = "Java development environment with JDK 17 and IntelliJ IDEA";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            openjdk17-bootstrap
            jetbrains.idea-community
          ];
          env = {
            JAVA_HOME = "${pkgs.jdk17}/lib/openjdk";
          };
        };
      }
    );
}
