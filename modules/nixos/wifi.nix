{ config, ... }:
let
  open = n: {
    connection = {
      id = "$WIFI_${n}_SSID";
      type = "wifi";
    };
    wifi = {
      ssid = "$WIFI_${n}_SSID";
      mode = "infrastructure";
    };
    ipv4.method = "auto";
    ipv6.method = "auto";
  };

  secured =
    n:
    open n
    // {
      wifi-security = {
        key-mgmt = "wpa-psk";
        psk = "$WIFI_${n}_PSK";
      };
    };
in
{
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [ config.sops.secrets.wifi.path ];

    profiles = {
      wifi-1 = secured "1";
      wifi-2 = secured "2";
      wifi-3 = open "3";
    };
  };
}
