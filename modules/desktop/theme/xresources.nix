{ config, lib, ... }:

{
  options = {
    desktop.theme.xresources.enable = lib.mkEnableOption "Enable Xresources theming";
  };

  config = lib.mkIf config.desktop.theme.xresources.enable {
    xresources.properties = {
      "*.alpha" = 1;
      "*.font" = "Roboto Medium:size=12";

      "Xft.autohint" = 1;
      "Xft.antialias" = 1;
      "Xft.hinting" = true;
      "Xft.hintstyle" = "hintslight";
      "Xft.rgba" = "rgba";
      "Xft.lcdfilter" = "lcddefault";

      # onelight
      "*.foreground" = "#383a42";
      "*.background" = "#fafafa";
      "*.cursorColor" = "#bfceff";
      "*.color0" = "#383a42";
      "*.color8" = "#4f525e";
      "*.color1" = "#e45649";
      "*.color9" = "#e06c75";
      "*.color2" = "#50a14f";
      "*.color10" = "#98c379";
      "*.color3" = "#c18401";
      "*.color11" = "#e5c07b";
      "*.color4" = "#0184bc";
      "*.color12" = "#61afef";
      "*.color5" = "#a626a4";
      "*.color13" = "#c678dd";
      "*.color6" = "#0997b3";
      "*.color14" = "#56b6c2";
      "*.color7" = "#fafafa";
      "*.color15" = "#ffffff";
      "*.colorBD" = "#abb2bf";
    };
  };
}
