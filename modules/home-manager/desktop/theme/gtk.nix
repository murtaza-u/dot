{ pkgs, config, lib, ... }:

{
  options = {
    desktop.theme.gtk.enable = lib.mkEnableOption "Enable GTK theming";
  };

  config = lib.mkIf config.desktop.theme.gtk.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Breeze";
        package = pkgs.breeze-gtk;
      };
      font = {
        name = "Roboto Medium";
        size = 13;
        package = pkgs.roboto;
      };
      iconTheme = {
        name = "breeze";
        package = pkgs.breeze-icons;
      };
      cursorTheme = {
        name = "breeze_cursors";
      };
    };
  };
}
