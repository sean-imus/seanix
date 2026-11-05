{
  lib,
  pkgs,
  ...
}:
let
  hideDesktopEntries = import ../lib/hide-desktop-entries.nix { inherit lib pkgs; };

  # Everforest Dark as [ R G B ], the format Chromium themes expect
  bg0 = [
    45
    53
    59
  ];
  bg1 = [
    52
    63
    68
  ];
  bg2 = [
    61
    72
    77
  ];
  grey1 = [
    133
    146
    137
  ];
  fg = [
    211
    198
    170
  ];
  green = [
    167
    192
    128
  ];

  profiles = {
    work-admin = "Work-Admin";
    work-normal = "Work-Normal";
    school = "School";
    privat = "Privat";
  };

  ublockLite = "ddkjiahejlhfcafbddmgiahcphecmpfh";
  vimium = "dbepggeogbaibhgnhhndojpepiihcmeb";
  claude = "fcoeoabgfenejglbffodgkkbkcdhcgfn";

  commonExtensions = [
    ublockLite
    vimium
  ];
  extensionsFor = key: commonExtensions ++ lib.optional (key == "privat") claude;

  everforestTheme = pkgs.writeTextDir "manifest.json" (
    builtins.toJSON {
      manifest_version = 3;
      name = "Everforest";
      version = "1.0";
      theme.colors = {
        frame = bg0;
        frame_inactive = bg1;
        toolbar = bg1;
        toolbar_text = fg;
        toolbar_button_icon = fg;
        tab_text = fg;
        tab_background_text = grey1;
        bookmark_text = fg;
        omnibox_background = bg2;
        omnibox_text = fg;
        ntp_background = bg0;
        ntp_text = fg;
        ntp_link = green;
      };
    }
  );

  updateUrl = builtins.toJSON {
    external_update_url = "https://clients2.google.com/service/update2/crx";
  };
in
{
  programs.chromium.enable = true;

  home.packages = lib.mapAttrsToList (
    key: _:
    pkgs.writeShellScriptBin "chromium-${key}" ''
      exec chromium \
        --password-store=basic \
        --force-dark-mode \
        --enable-features=WebUIDarkMode \
        --load-extension=${everforestTheme} \
        --user-data-dir="$HOME/.config/chromium-${key}" "$@"
    ''
  ) profiles;

  home.file = lib.concatMapAttrs (
    key: _:
    lib.genAttrs' (extensionsFor key) (
      id: lib.nameValuePair ".config/chromium-${key}/External Extensions/${id}.json" { text = updateUrl; }
    )
  ) profiles;

  xdg = {
    desktopEntries = lib.mapAttrs' (
      key: name:
      lib.nameValuePair "chromium-${key}" {
        name = "Chromium (${name})";
        genericName = "Web Browser";
        exec = "chromium-${key} %U";
        icon = "chromium";
        categories = [
          "Network"
          "WebBrowser"
        ];
        mimeType = [
          "text/html"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
        ];
      }
    ) profiles;
    mimeApps = {
      enable = true;
      defaultApplications = lib.genAttrs [
        "application/json"
        "application/pdf"
        "image/avif"
        "image/bmp"
        "image/gif"
        "image/jpeg"
        "image/png"
        "image/svg+xml"
        "image/webp"
        "text/html"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ] (_: "chromium-privat.desktop");
    };
    dataFile = hideDesktopEntries pkgs.chromium [ "chromium-browser" ];
  };
}
