{ config, lib, ... }:

{
  options = {
    desktop.zathura.enable = lib.mkEnableOption "Enable zathura";
  };

  config = lib.mkIf config.desktop.zathura.enable {
    programs.zathura = {
      enable = true;
      mappings = {
        R = "rotate";
        i = "recolor";
      };
      options = {
        statusbar-h-padding = 0;
        statusbar-v-padding = 0;
        page-padding = 1;
        selection-clipboard = "clipboard";
        recolor-lightcolor = "#161515";
        recolor-keephue = true;
        default-bg = "#ffffff";
      };
    };
  };
}
