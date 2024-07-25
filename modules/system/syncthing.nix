{ pkgs, config, lib, ... }:

{
  options = {
    system.syncthing.enable = lib.mkEnableOption "Enable syncthing";
  };

  config = lib.mkIf config.system.syncthing.enable {
    services.syncthing = {
      enable = true;
    };
    home.packages = [ pkgs.syncthingtray ];
  };
}
