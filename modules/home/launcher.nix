let
  # Everforest Dark without '#'; fuzzel wants RRGGBBAA, so alpha is appended below
  bg0 = "2d353b";
  grey0 = "7a8478";
  fg = "d3c6aa";
  green = "a7c080";
in
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        dpi-aware = false;
        namespace = "fuzzel";
        sort-result = false;
        icons-enabled = false;
      };
      colors = {
        background = "${bg0}ff";
        text = "${fg}ff";
        prompt = "${grey0}ff";
        input = "${fg}ff";
        match = "${green}ff";
        selection = "${green}44";
        selection-text = "${fg}ff";
        selection-match = "${green}ff";
        border = "${green}ff";
      };
      border = {
        width = 2;
        radius = 0;
      };
    };
  };
}
