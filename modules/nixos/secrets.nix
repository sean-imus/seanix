# sops-nix: where the age key lives, and a sops wrapper that reads the
# root-only key via sudo. The secrets themselves are declared where they are used.
{ config, pkgs, ... }:
{
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";

  home-manager.sharedModules = [
    {
      home.packages = [
        (pkgs.writeShellScriptBin "sops" ''
          export SOPS_AGE_KEY="''${SOPS_AGE_KEY:-$(sudo cat ${config.sops.age.keyFile})}"
          exec ${pkgs.sops}/bin/sops "$@"
        '')
      ];
    }
  ];
}
