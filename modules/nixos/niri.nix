{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  environment.systemPackages = [
    pkgs.playerctl
    pkgs.wiremix
    pkgs.bluetui
  ];
}
