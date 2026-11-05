# Screen locking: swaylock, locked after 5 minutes idle and before sleep,
# monitors off after 10 minutes. Super+Alt+L locks manually.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Everforest Dark without '#', the format swaylock expects
  bg0 = "2d353b";
  bg1 = "343f44";
  fg = "d3c6aa";
  red = "e67e80";
  green = "a7c080";
  aqua = "83c092";

  lock = "${pkgs.swaylock}/bin/swaylock -f";
  niri = lib.getExe config.programs.niri.package;
in
{
  home-manager.sharedModules = [
    {
      programs.swaylock = {
        enable = true;
        settings = {
          color = bg0;
          inside-color = bg1;
          ring-color = green;
          key-hl-color = aqua;
          bs-hl-color = red;
          text-color = fg;
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
  ];
}
