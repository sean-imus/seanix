{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  environment.systemPackages = [
    pkgs.wl-clipboard
    pkgs.cliphist
    pkgs.playerctl
    pkgs.wiremix
    pkgs.bluetui
  ];
}
