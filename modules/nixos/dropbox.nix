# Dropbox mounted at ~/Dropbox with rclone. Files download when opened and are
# kept in a size-limited cache. The OAuth token comes from secrets/dropbox.yaml.
{ config, ... }:
{
  sops.secrets.dropbox-token = {
    sopsFile = ../../secrets/dropbox.yaml;
    key = "token";
    owner = "sean";
  };

  home-manager.sharedModules = [
    {
      programs.rclone = {
        enable = true;
        remotes.dropbox = {
          config.type = "dropbox";
          secrets.token = config.sops.secrets.dropbox-token.path;
          mounts."" = {
            enable = true;
            mountPoint = "/home/sean/Dropbox";
            options = {
              vfs-cache-max-size = "50G";
              vfs-cache-max-age = "720h";
            };
          };
        };
      };
    }
  ];
}
