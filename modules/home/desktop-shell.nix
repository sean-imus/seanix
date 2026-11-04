{ theme, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.main = {
      layer = "top";
      position = "bottom";
      height = 18;
      spacing = 6;
      modules-left = [ "clock" ];
      modules-right = [
        "power-profiles-daemon"
        "pulseaudio#source"
        "pulseaudio"
        "battery"
      ];
      clock = {
        format = "{:%H:%M %d.%m.%Y}";
        tooltip = false;
      };
      power-profiles-daemon = {
        format = "PERF {icon}";
        format-icons = {
          performance = "high";
          balanced = "mid";
          power-saver = "low";
        };
        tooltip = false;
      };
      "pulseaudio#source" = {
        format = "{format_source}";
        format-source = "MIC {volume}%";
        format-source-muted = "MIC muted";
        on-click = "swayosd-client --input-volume mute-toggle";
        on-scroll-up = "swayosd-client --input-volume +5";
        on-scroll-down = "swayosd-client --input-volume -5";
        tooltip = false;
      };
      pulseaudio = {
        format = "VOL {volume}%";
        format-muted = "VOL muted";
        on-click = "swayosd-client --output-volume mute-toggle";
        on-scroll-up = "swayosd-client --output-volume +5";
        on-scroll-down = "swayosd-client --output-volume -5";
        tooltip = false;
      };
      battery = {
        format = "BAT {capacity}%";
        states.critical = 15;
        tooltip = false;
      };
    };
    style = ''
      * {
        font-family: "${theme.fontFamily}";
        font-size: 11px;
        min-height: 0;
        padding: 0;
        margin: 0;
        border: none;
        border-radius: 0;
      }
      window#waybar {
        background: transparent;
        color: ${theme.hex.fg};
      }
      .modules-left { margin-left: 6px; }
      .modules-right { margin-right: 6px; }
      #power-profiles-daemon.performance { color: ${theme.hex.red}; }
      #power-profiles-daemon.balanced { color: ${theme.hex.yellow}; }
      #power-profiles-daemon.power-saver { color: ${theme.hex.green}; }
      #pulseaudio.muted, #pulseaudio.source-muted { color: ${theme.hex.grey0}; }
      #battery.charging, #battery.full { color: ${theme.hex.green}; }
      #battery.critical:not(.charging) { color: ${theme.hex.red}; }
    '';
  };

  services = {
    mako = {
      enable = true;
      settings = {
        font = "${theme.fontFamily} 10";
        background-color = theme.hex.bg1;
        text-color = theme.hex.fg;
        border-color = theme.hex.green;
        progress-color = "over ${theme.hex.bg3}";
        border-size = 2;
        default-timeout = 6000;
        "urgency=critical" = {
          border-color = theme.hex.red;
          default-timeout = 0;
        };
        "mode=do-not-disturb".invisible = 1;
      };
    };

    swayosd.enable = true;

    polkit-gnome.enable = true;
  };

  wayland.windowManager.niri.settings.binds = {
    "Mod+Shift+D".spawn-sh = "makoctl mode -t do-not-disturb";
    "Mod+Shift+N".spawn-sh = "makoctl dismiss -a";
  };
}
