{ pkgs, ... }:

{
  xdg.configFile.vifm.source = ../../store/vifm;
  home.packages = [ pkgs.vifm ];
}
