{ lib, pkgs, ... }:
let
  hideDesktopEntries = import ../lib/hide-desktop-entries.nix { inherit lib pkgs; };
in
{
  services.printing.enable = true;

  hardware.sane.enable = true;

  environment.systemPackages = [ pkgs.simple-scan ];

  home-manager.sharedModules = [
    { xdg.dataFile = hideDesktopEntries pkgs.cups [ "cups" ]; }
  ];
}
