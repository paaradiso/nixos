{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.kickstart.overlays.default ];
  
  environment.systemPackages = [ pkgs.nvim-pkg ];
}
