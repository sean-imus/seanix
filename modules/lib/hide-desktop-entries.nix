# Hides a package's launcher entries by overriding them in ~/.local/share/applications
# with a copy that sets NoDisplay=true. Returns an attrset for xdg.dataFile.
#
#   xdg.dataFile = hideDesktopEntries pkgs.foot [ "foot" "footclient" ];
{ lib, pkgs }:
package: names:
lib.genAttrs' names (
  name:
  lib.nameValuePair "applications/${name}.desktop" {
    source = pkgs.runCommandLocal "${name}-nodisplay.desktop" { } ''
      sed '/^\[Desktop Entry\]$/a NoDisplay=true' ${package}/share/applications/${name}.desktop > $out
    '';
  }
)
