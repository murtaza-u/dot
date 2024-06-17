{ config, lib, ... }:

{
  options = {
    editor.emacs.enable = lib.mkEnableOption "Enable emacs";
  };

  config = lib.mkIf config.editor.emacs.enable {
    programs.emacs = {
      enable = true;
      extraPackages = epkgs: [ epkgs.vterm ];
    };
    xdg.configFile.emacs = {
      source = ../../store/emacs;
      recursive = true;
    };
  };
}
