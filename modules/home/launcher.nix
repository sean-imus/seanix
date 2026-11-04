{ theme, ... }:
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
        background = "${theme.bg0}ff";
        text = "${theme.fg}ff";
        prompt = "${theme.grey0}ff";
        input = "${theme.fg}ff";
        match = "${theme.green}ff";
        selection = "${theme.green}44";
        selection-text = "${theme.fg}ff";
        selection-match = "${theme.green}ff";
        border = "${theme.green}ff";
      };
      border = {
        width = 2;
        radius = 0;
      };
    };
  };
}
