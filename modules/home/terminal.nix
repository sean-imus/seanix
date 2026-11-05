{
  pkgs,
  shadowDesktopEntries,
  ...
}:
let
  # Everforest Dark without '#', the format foot expects
  bg0 = "2d353b";
  bg4 = "4f585e";
  fg = "d3c6aa";
  red = "e67e80";
  yellow = "dbbc7f";
  green = "a7c080";
  aqua = "83c092";
  blue = "7fbbb3";
  purple = "d699b6";
in
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=10";
        term = "xterm-256color";
      };
      scrollback.lines = 10000;
      cursor.style = "beam";
      # Everforest uses the same palette for the regular and bright ANSI colours
      colors-dark = {
        foreground = fg;
        background = bg0;

        regular0 = bg4;
        regular1 = red;
        regular2 = green;
        regular3 = yellow;
        regular4 = blue;
        regular5 = purple;
        regular6 = aqua;
        regular7 = fg;

        bright0 = bg4;
        bright1 = red;
        bright2 = green;
        bright3 = yellow;
        bright4 = blue;
        bright5 = purple;
        bright6 = aqua;
        bright7 = fg;
      };
    };
  };

  xdg.dataFile = shadowDesktopEntries pkgs.foot [
    "foot"
    "footclient"
    "foot-server"
  ];
}
