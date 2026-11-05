# niri window manager, user side. How niri is started is in nixos/niri.nix.
{
  imports = [
    ./keybindings.nix
    ./outputs.nix
    ./settings.nix
  ];

  wayland.windowManager.niri = {
    enable = true;
    portalPackage = null;
    systemd.enable = false;
  };
}
