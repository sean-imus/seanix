# niri window manager, system side, and how the desktop starts at boot.
# The niri configuration itself is in home/niri/.
{
  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  # Boot straight into niri: log in on tty1 without a password once per boot
  # (the disk is already unlocked by LUKS), then fish starts the session.
  # Later logins, e.g. after quitting niri, ask for the password again.
  services.getty = {
    autologinUser = "sean";
    autologinOnce = true;
  };

  home-manager.sharedModules = [
    {
      programs.fish.interactiveShellInit = ''
        if test -z "$DISPLAY"; and test -z "$WAYLAND_DISPLAY"; and test (tty) = "/dev/tty1"
          exec niri-session
        end
      '';
    }
  ];
}
