{ pkgs, config, lib, ... }:

{
  options = {
    desktop.nsxiv.enable = lib.mkEnableOption "Enable nsxiv";
  };

  config = lib.mkIf config.desktop.nsxiv.enable {
    xdg.configFile.nsxiv.source = ../../store/nsxiv;
    home.packages = [ pkgs.nsxiv ];
  };
}
