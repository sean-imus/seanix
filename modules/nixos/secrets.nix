{ config, pkgs, ... }:
{
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets.wifi = {
      sopsFile = ../../secrets/wifi.env;
      format = "dotenv";
      key = "";
    };
  };

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
