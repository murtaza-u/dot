{ pkgs, config, lib, ... }:

{
  options = {
    tools.vifm.enable = lib.mkEnableOption "Enable vifm";
  };

  config = lib.mkIf config.tools.vifm.enable {
    xdg.configFile.vifm.source = ../../store/vifm;
    home.packages = [ pkgs.vifm ];
  };
}
