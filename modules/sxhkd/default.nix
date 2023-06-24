{ pkgs, ... }:

{
  xdg.configFile.sxhkd.source = ../../store/sxhkd;
  services.sxhkd.enable = true;
}
