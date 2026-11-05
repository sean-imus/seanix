# The user sean: account, login shell, and the home-manager modules under home/.
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

  # Users and passwords come only from this config
  users.mutableUsers = false;

  programs.fish = {
    enable = true;
    generateCompletions = false;
    useBabelfish = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    overwriteBackup = true;
    extraSpecialArgs = { inherit inputs; };
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
