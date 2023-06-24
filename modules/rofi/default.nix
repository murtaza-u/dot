{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = ../../store/rofi/theme.rasi;
    cycle = true;
    font = "IosevkaTerm Nerd Font Medium 14";
    plugins = with pkgs; [ rofi-emoji ];
    extraConfig = {
      show-icons = true;
      icon-theme = "breeze_icons";
      modi = "window,run,drun,emoji";
      drun-display-format = "{icon} {name}";
      display-window = "Windows: ";
      display-drun = "Applications: ";
      display-run = "Run: ";
      display-emoji = "Emoji: ";
    };
  };
}
