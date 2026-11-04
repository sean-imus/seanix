{ lib, pkgs, ... }:
{
  _module.args.shadowDesktopEntries =
    package: names:
    lib.genAttrs' names (
      name:
      lib.nameValuePair "applications/${name}.desktop" {
        source = pkgs.runCommandLocal "${name}-nodisplay.desktop" { } ''
          sed '/^\[Desktop Entry\]$/a NoDisplay=true' ${package}/share/applications/${name}.desktop > $out
        '';
      }
    );

  xdg.mimeApps.enable = true;
}
