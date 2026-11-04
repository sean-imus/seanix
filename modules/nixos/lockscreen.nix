{
  config,
  lib,
  pkgs,
  ...
}:
let
  lock = "${pkgs.swaylock}/bin/swaylock -f";
  niri = lib.getExe config.programs.niri.package;
in
{
  home-manager.sharedModules = [
    (
      { theme, ... }:
      {
        programs.swaylock = {
          enable = true;
          settings = {
            color = theme.bg0;
            inside-color = theme.bg1;
            ring-color = theme.green;
            key-hl-color = theme.aqua;
            bs-hl-color = theme.red;
            text-color = theme.fg;
          };
        };

        services.swayidle = {
          enable = true;
          events = {
            inherit lock;
            before-sleep = lock;
          };
          timeouts = [
            {
              timeout = 300;
              command = lock;
            }
            {
              timeout = 600;
              command = "${niri} msg action power-off-monitors";
              resumeCommand = "${niri} msg action power-on-monitors";
            }
          ];
        };

        wayland.windowManager.niri.settings.binds."Super+Alt+L".spawn-sh = "loginctl lock-session";
      }
    )
  ];
}
