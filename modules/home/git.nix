{ theme, ... }:
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
          theme.hex.green
          "bold"
        ];
        inactiveBorderColor = [ theme.hex.grey0 ];
        optionsTextColor = [ theme.hex.grey2 ];
        selectedLineBgColor = [ theme.hex.bg1 ];
        unstagedChangesColor = [ theme.hex.red ];
        defaultFgColor = [ theme.hex.fg ];
        searchingActiveBorderColor = [
          theme.hex.yellow
          "bold"
        ];
      };
    };
  };

  home.shellAliases = {
    lg = "lazygit";
  };
}
