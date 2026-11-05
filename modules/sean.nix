{ inputs, pkgs, ... }:
{
  users.users.sean = {
    isNormalUser = true;
    hashedPasswordFile = "/home/sean/.secrets/password.txt";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.fish;
  };

  programs.fish = {
    enable = true;
    generateCompletions = false;
    useBabelfish = true;
  };

  home-manager.users.sean = {
    imports = [
      inputs.nix-index-database.homeModules.default
      ./home/browser.nix
      ./home/desktop-shell.nix
      ./home/editor.nix
      ./home/extra-apps.nix
      ./home/git.nix
      ./home/launcher.nix
      ./home/niri
      ./home/shell.nix
      ./home/terminal.nix
      ./home/appearance.nix
    ];

    programs.nix-index.enableFishIntegration = false;
    programs.nix-index-database.comma.enable = true;

    home.stateVersion = "26.11";
  };
}
