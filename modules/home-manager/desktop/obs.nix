{ pkgs, config, lib, ... }:

{
  options = {
    desktop.obs.enable = lib.mkEnableOption "Enable OBS Studio";
  };

  config = lib.mkIf config.desktop.obs.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
