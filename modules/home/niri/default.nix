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
