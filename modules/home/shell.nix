{
  lib,
  pkgs,
  ...
}:
let
  hideDesktopEntries = import ../lib/hide-desktop-entries.nix { inherit lib pkgs; };

  # Everforest Dark
  bg0 = "#2d353b";
  bg1 = "#343f44";
  grey0 = "#7a8478";
  fg = "#d3c6aa";
  red = "#e67e80";
  yellow = "#dbbc7f";
  green = "#a7c080";
  aqua = "#83c092";
  purple = "#d699b6";
in
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
          style = "bold ${yellow}";
        };

        directory = {
          format = "([$path]($style) )";
          style = "bold ${aqua}";
          truncate_to_repo = false;
        };

        git_branch = {
          format = "[$branch ]($style)";
          style = "bold ${purple}";
        };

        git_status = {
          format = "([$all_status$ahead_behind]($style) )";
          style = "bold ${red}";
        };

        character = {
          success_symbol = "[❯](bold ${green})";
          error_symbol = "[❯](bold ${red})";
        };
      };
    };

    fzf = {
      enable = true;
      colors = {
        bg = bg0;
        "bg+" = bg1;
        border = grey0;
        inherit fg;
        "fg+" = fg;
        header = aqua;
        hl = green;
        "hl+" = green;
        info = yellow;
        marker = red;
        pointer = purple;
        prompt = red;
        spinner = green;
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

  xdg.dataFile = hideDesktopEntries pkgs.btop [ "btop" ];
}
