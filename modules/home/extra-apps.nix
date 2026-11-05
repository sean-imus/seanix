{
  lib,
  pkgs,
  ...
}:
let
  hideDesktopEntries = import ../lib/hide-desktop-entries.nix { inherit lib pkgs; };
in
{
  home.packages = [
    pkgs.libreoffice-stable
  ];

  programs.mpv = {
    enable = true;
    config = {
      hwdec = "vaapi";
      gpu-context = "wayland";
    };
  };

  xdg = {
    dataFile =
      hideDesktopEntries pkgs.libreoffice-stable [
        "base"
        "draw"
        "impress"
        "math"
        "startcenter"
        "xsltfilter"
      ]
      // hideDesktopEntries pkgs.mpv [ "mpv" ];

    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/markdown" = "writer.desktop";
        "text/plain" = "writer.desktop";
        "text/x-markdown" = "writer.desktop";
      };
    };
  };
}
