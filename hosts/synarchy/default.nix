# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      
      ../../modules/core/boot.nix
      ../../modules/core/users.nix
    ];

  boot.loader.grub.enable = false;

  networking.hostName = "synarchy"; # Define your hostname.
  networking.hostId = "cacabeef";

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.05";

}

