{pkgs, ...}: {
  environment.systemPackages = [(pkgs.writeShellScriptBin "cs-toggle-res" (builtins.readFile ../../files/scripts/cs-toggle-res))];
}
