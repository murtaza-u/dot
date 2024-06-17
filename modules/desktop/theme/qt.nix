{ pkgs, config, lib, ... }:

{
  options = {
    desktop.theme.qt.enable = lib.mkEnableOption "Enable QT theming";
  };

  config = lib.mkIf config.desktop.theme.qt.enable {
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style = {
        name = "Breeze";
        package = pkgs.breeze-qt5;
      };
    };
  };
}
