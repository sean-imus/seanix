{ config, ... }:
{
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [ config.sops.secrets.wifi.path ];

    profiles.wifi-1 = {
      connection = {
        id = "$WIFI_1_SSID";
        type = "wifi";
      };
      wifi = {
        ssid = "$WIFI_1_SSID";
        mode = "infrastructure";
      };
      wifi-security = {
        key-mgmt = "wpa-psk";
        psk = "$WIFI_1_PSK";
      };
      ipv4.method = "auto";
      ipv6.method = "auto";
    };
  };
}
