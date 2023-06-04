{ config, pkgs, ... }: {
  services.mattermost = {
    enable = true;
    siteUrl = "https://mattermost.murtazau.xyz";
    mutableConfig = true;
    localDatabaseCreate = true;
    localDatabaseName = "mattermost";
    localDatabaseUser = "mattermost";
    localDatabasePassword = "mattermost";
  };

  services.postgresqlBackup = {
    enable = true;
    databases = [ "mattermost" ];
  };
}
