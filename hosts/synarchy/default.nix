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
      ../../modules/core/nix.nix
    ];

  boot.loader.grub.enable = false;

  networking.hostName = "synarchy"; # Define your hostname.
  networking.hostId = "cacabeef";
  networking.interfaces.ens18.ipv4.addresses = [ {
    address = "10.1.1.40";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "10.1.1.1";
  networking.nameservers = [ "10.1.1.1" ];

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.05";

}

