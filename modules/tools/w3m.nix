{ pkgs, config, lib, ... }:

{
  options = {
    tools.w3m.enable = lib.mkEnableOption "Enable w3m";
  };

  config = lib.mkIf config.tools.w3m.enable {
    home.file.".w3m".source = ../../store/w3m;
    home.packages = [ pkgs.w3m ];
  };
}
