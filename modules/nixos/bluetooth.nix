{ pkgs, ... }:
{
  hardware.bluetooth.enable = true;

  environment.systemPackages = [ pkgs.bluetui ];

  home-manager.sharedModules = [
    {
      wayland.windowManager.niri.settings = {
        # Pairing and connecting in a floating terminal
        binds."Mod+Ctrl+B".spawn = [
          "foot"
          "--app-id"
          "bluetui"
          "bluetui"
        ];

        _children = [
          {
            window-rule._children = [
              {
                match._props.app-id = "^bluetui$";
                open-floating = true;
              }
            ];
          }
        ];
      };
    }
  ];
}
