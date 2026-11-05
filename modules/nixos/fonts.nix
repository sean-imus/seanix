{ pkgs, ... }:
{
  # Modules refer to the monospace font by its name, "JetBrainsMono Nerd Font"
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts-color-emoji
  ];
}
