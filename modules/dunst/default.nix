{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Breeze";
      package = pkgs.breeze-icons;
    };
    settings = rec {
      global = {
        width = 500;
        height = 500;
        origin = "top-right";
        offset = "5x5";
        transparency = 15;
        separator_height = 5;
        padding = 20;
        gap_size = 20;
        horizontal_padding = 20;
        text_icon_padding = 10;
        frame_width = 2;
        frame_color = "#eeeeee";
        font = "Roboto Medium 14";
        icon_position = "left";
        corner_radius = 8;
        force_xwayland = false;
        progress_bar = true;
        icon_path = "/home/murtaza/.dot/store/dunst";
      };
      urgency_normal = {
        background = "#eeeeee";
        foreground = "#000000";
        timeout = 5;
      };
      urgency_low = urgency_normal;
      urgency_critical = {
        background = "#eeeeee";
        foreground = "#000000";
        frame_color = "#ff0000";
        timeout = 5;
      };
    };
  };
}
