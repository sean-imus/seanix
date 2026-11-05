{
  wayland.windowManager.niri.settings._children = [
    {
      output = {
        _args = [ "eDP-1" ];
        position._props = {
          x = 0;
          y = 0;
        };
      };
    }
    {
      output = {
        _args = [ "iiyama Corporation PL2770H 0x0000011F" ];
        mode._args = [ "1920x1080" ];
        position._props = {
          x = -1920;
          y = 0;
        };
      };
    }
    {
      output = {
        _args = [ "iiyama Corporation PL2770H 0x00000124" ];
        mode._args = [ "1920x1080" ];
        position._props = {
          x = -3840;
          y = 0;
        };
        focus-at-startup = { };
      };
    }
    {
      output = {
        _args = [ "GIGA-BYTE TECHNOLOGY CO., LTD. M27U 23463B001145" ];
        mode._args = [ "3840x2160@60.000" ];
        scale._args = [ 1.5 ];
        # Centered above eDP-1 (logical 2560x1440 over 1920x1080).
        position._props = {
          x = -320;
          y = -1440;
        };
      };
    }
  ];
}
