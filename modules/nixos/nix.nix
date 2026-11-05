# Nix itself: flakes, no channels, and nh for rebuilding and cleanup.
{
  nix = {
    channel.enable = false;
    settings = {
      download-buffer-size = 134217728;
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # nh wraps nixos-rebuild (nh os switch) and cleans old generations weekly
  programs.nh = {
    enable = true;
    flake = "/home/sean/seanix";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --optimise";
    };
  };
}
