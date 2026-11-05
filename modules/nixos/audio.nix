{ pkgs, ... }:
let
  locked = bind: { _props.allow-when-locked = true; } // bind;
in
{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # Lets PipeWire request realtime scheduling to avoid audio dropouts
  security.rtkit.enable = true;

  environment.systemPackages = [
    pkgs.playerctl
    pkgs.wiremix
  ];

  home-manager.sharedModules = [
    {
      # Tracks the most recently active player, so playerctl controls that one
      services.playerctld.enable = true;

      wayland.windowManager.niri.settings = {
        # Volume keys go through swayosd (desktop-shell.nix) to show an on-screen bar
        binds = {
          "XF86AudioRaiseVolume" = locked {
            spawn-sh = "swayosd-client --output-volume +10 --max-volume 100";
          };
          "XF86AudioLowerVolume" = locked { spawn-sh = "swayosd-client --output-volume -10"; };
          "XF86AudioMute" = locked { spawn-sh = "swayosd-client --output-volume mute-toggle"; };
          "XF86AudioMicMute" = locked { spawn-sh = "swayosd-client --input-volume mute-toggle"; };
          "XF86AudioPlay" = locked { spawn-sh = "playerctl play-pause"; };
          "XF86AudioStop" = locked { spawn-sh = "playerctl stop"; };
          "XF86AudioPrev" = locked { spawn-sh = "playerctl previous"; };
          "XF86AudioNext" = locked { spawn-sh = "playerctl next"; };

          # Mixer in a floating terminal
          "Mod+Ctrl+A".spawn = [
            "foot"
            "--app-id"
            "wiremix"
            "wiremix"
            "-v"
            "playback"
          ];
        };

        _children = [
          {
            window-rule._children = [
              {
                match._props.app-id = "^wiremix$";
                open-floating = true;
              }
            ];
          }
        ];
      };
    }
  ];
}
