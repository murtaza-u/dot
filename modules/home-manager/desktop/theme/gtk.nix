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
        package = pkgs.kdePackages.breeze-gtk;
      };
      font = {
        name = "Roboto";
        size = 11;
        package = pkgs.roboto;
      };
      iconTheme = {
        name = "breeze";
        package = pkgs.kdePackages.breeze-icons;
      };
      cursorTheme = {
        name = "breeze_cursors";
      };
    };
  };
}
