{ config, lib, ... }:

{
  options = {
    desktop.mpv.enable = lib.mkEnableOption "Enable mpv";
  };

  config = lib.mkIf config.desktop.mpv.enable {
    programs.mpv.enable = true;
  };
}
