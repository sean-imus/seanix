# GTK theme (Everforest Dark), icon theme (Papirus) and mouse cursor.
# The wallpaper is set in niri/settings.nix.
{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Everforest-Dark";
      package = pkgs.everforest-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };
  };

  home.pointerCursor = {
    enable = true;
    name = "everforest-cursors";
    package = pkgs.everforest-cursors;
    size = 24;
    gtk.enable = true;
  };
}
