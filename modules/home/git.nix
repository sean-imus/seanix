# Git identity, the GitHub CLI and lazygit.
let
  # Everforest Dark
  bg1 = "#343f44";
  grey0 = "#7a8478";
  grey2 = "#9da9a0";
  fg = "#d3c6aa";
  red = "#e67e80";
  yellow = "#dbbc7f";
  green = "#a7c080";
in
{
  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "sean tietz";
        email = "sean.tietz2@gmail.com";
      };
    };

    gh.enable = true;

    lazygit = {
      enable = true;
      settings.gui.theme = {
        activeBorderColor = [
          green
          "bold"
        ];
        inactiveBorderColor = [ grey0 ];
        optionsTextColor = [ grey2 ];
        selectedLineBgColor = [ bg1 ];
        unstagedChangesColor = [ red ];
        defaultFgColor = [ fg ];
        searchingActiveBorderColor = [
          yellow
          "bold"
        ];
      };
    };
  };

  home.shellAliases = {
    lg = "lazygit";
  };
}
