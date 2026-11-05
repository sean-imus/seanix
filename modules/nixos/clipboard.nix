# Clipboard history: everything copied is kept by cliphist,
# Mod+Ctrl+Y picks an older entry and copies it again.
{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.wl-clipboard
    pkgs.cliphist
  ];

  home-manager.sharedModules = [
    {
      wayland.windowManager.niri.settings = {
        # Record every copied text and PNG image into the cliphist history
        _children = [
          {
            spawn-at-startup._args = [
              "wl-paste"
              "--watch"
              "cliphist"
              "store"
            ];
          }
          {
            spawn-at-startup._args = [
              "wl-paste"
              "--type"
              "image/png"
              "--watch"
              "cliphist"
              "store"
            ];
          }
        ];

        # Pick an entry from the history with fuzzel and copy it again
        binds."Mod+Ctrl+Y".spawn-sh =
          "cliphist list | fuzzel --dmenu --with-nth 2 | cliphist decode | wl-copy";
      };
    }
  ];
}
