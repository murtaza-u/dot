{ config, lib, ... }:

{
  options = {
    tools.direnv.enable = lib.mkEnableOption "Enable direnv";
  };

  config = lib.mkIf config.tools.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
