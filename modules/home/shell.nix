{
  pkgs,
  theme,
  shadowDesktopEntries,
  ...
}:
{
  manual.manpages.enable = false;

  programs = {
    fish = {
      enable = true;
      generateCompletions = false;
      functions.fish_greeting = "";
      interactiveShellInit = ''
        if test -z "$DISPLAY"; and test -z "$WAYLAND_DISPLAY"; and test (tty) = "/dev/tty1"
          exec niri-session
        end
      '';
    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        format = "$cmd_duration$directory$git_branch$git_status$character";

        cmd_duration = {
          min_time = 2000;
          format = "[($duration)]($style) ";
          style = "bold ${theme.hex.yellow}";
        };

        directory = {
          format = "([$path]($style) )";
          style = "bold ${theme.hex.aqua}";
          truncate_to_repo = false;
        };

        git_branch = {
          format = "[$branch ]($style)";
          style = "bold ${theme.hex.purple}";
        };

        git_status = {
          format = "([$all_status$ahead_behind]($style) )";
          style = "bold ${theme.hex.red}";
        };

        character = {
          success_symbol = "[❯](bold ${theme.hex.green})";
          error_symbol = "[❯](bold ${theme.hex.red})";
        };
      };
    };

    fzf = {
      enable = true;
      colors = {
        bg = theme.hex.bg0;
        "bg+" = theme.hex.bg1;
        border = theme.hex.grey0;
        fg = theme.hex.fg;
        "fg+" = theme.hex.fg;
        header = theme.hex.aqua;
        hl = theme.hex.green;
        "hl+" = theme.hex.green;
        info = theme.hex.yellow;
        marker = theme.hex.red;
        pointer = theme.hex.purple;
        prompt = theme.hex.red;
        spinner = theme.hex.green;
      };
      defaultOptions = [
        "--height=40%"
        "--layout=reverse"
        "--border"
      ];
    };

    zoxide = {
      enable = true;
      options = [ "--cmd=cd" ];
    };

    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };

    carapace.enable = true;

    btop = {
      enable = true;
      settings = {
        update_ms = 1000;
        color_theme = "everforest-dark-medium";
      };
    };

    fastfetch.enable = true;

    tealdeer = {
      enable = true;
      enableAutoUpdates = false;
      settings.updates.auto_update = true;
    };
  };

  home = {
    shellAliases = {
      rbu = "nix flake update && git commit flake.lock -m 'chore(inputs): updated hashes'";
      ff = "fastfetch";
    };
    packages = with pkgs; [
      bat
      ncdu
    ];
  };

  xdg.dataFile = shadowDesktopEntries pkgs.btop [ "btop" ];
}
