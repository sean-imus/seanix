{ pkgs, ... }:
{
  sops = {
    age.keyFile = "/home/sean/.config/sops/age/keys.txt";

    secrets.wifi = {
      sopsFile = ../../secrets/wifi.env;
      format = "dotenv";
      key = "";
    };
  };

  home-manager.sharedModules = [
    { home.packages = [ pkgs.sops ]; }
  ];
}
