let
  themes = {
    oneLight = {
      primary = {
        background = "#fafafa";
        foreground = "#383a42";
      };
      normal = {
        black = "#383a42";
        red = "#e45649";
        green = "#50a14f";
        yellow = "#c18401";
        blue = "#0184bc";
        magenta = "#a626a4";
        cyan = "#0997b3";
        white = "#fafafa";
      };
      bright = {
        black = "#383a42";
        red = "#e45649";
        green = "#50a14f";
        yellow = "#c18401";
        blue = "#0184bc";
        magenta = "#a626a4";
        cyan = "#0997b3";
        white = "#fafafa";
      };
    };
    modusOperandi = {
      primary = {
        background = "#f8f8ff";
        foreground = "#000000";
      };
      normal = {
        black = "#a9a9a9";
        red = "#a60000";
        green = "#006800";
        yellow = "#6f5500";
        blue = "#0031a9";
        magenta = "#721045";
        cyan = "#005e8b";
        white = "#000000";
      };
      bright = {
        black = "#708090";
        red = "#d00000";
        green = "#008900";
        yellow = "#808000";
        blue = "#0000ff";
        magenta = "#dd22dd";
        cyan = "#008899";
        white = "#595959";
      };
      indexed_colors = [
        {
          index = 16;
          color = "#884900";
        }
        {
          index = 17;
          color = "#7f0000";
        }
      ];
    };
    gruvboxDark = {
      primary = {
        background = "#1d2021";
        foreground = "#ebdbb2";
      };
      normal = {
        black = "#282828";
        red = "#cc241d";
        green = "#98971a";
        yellow = "#d79921";
        blue = "#458588";
        magenta = "#b16286";
        cyan = "#689d6a";
        white = "#a89984";
      };
      bright = {
        black = "#928374";
        red = "#fb4934";
        green = "#b8bb26";
        yellow = "#fabd2f";
        blue = "#83a598";
        magenta = "#d3869b";
        cyan = "#8ec07c";
        white = "#ebdbb2";
      };
    };
    tokyonightDay = {
      primary = {
        background = "#f8f8ff";
        foreground = "#000000";
      };
      normal = {
        black = "#b4b5b9";
        red = "#f52a65";
        green = "#587539";
        yellow = "#8c6c3e";
        blue = "#1c05b3";
        magenta = "#391e5d";
        cyan = "#007197";
        white = "#6172b0";
      };
      bright = {
        black = "#a1a6c5";
        red = "#f52a65";
        green = "#587539";
        yellow = "#8c6c3e";
        blue = "#2e7de9";
        magenta = "#9854f1";
        cyan = "#007197";
        white = "#3760bf";
      };
      indexed_colors = [
        {
          index = 16;
          color = "#b15c00";
        }
        {
          index = 17;
          color = "#c64343";
        }
      ];
    };
  };
in
{ config, lib, ... }:
{
  options = {
    desktop.alacritty.enable = lib.mkEnableOption "Enable alacritty";
  };

  config = lib.mkIf config.desktop.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          dynamic_padding = true;
          opacity = 1.0;
          dynamic_title = true;
        };
        scrolling = {
          history = 100000;
          multiplier = 3;
        };
        font = {
          normal = {
            family = "ZedMono Nerd Font";
            style = "Medium";
          };
          bold = {
            family = "ZedMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "ZedMono Nerd Font";
            style = "Italic";
          };
          bold_italic = {
            family = "ZedMono Nerd Font";
            style = "Bold Italic";
          };
          size = 16;
        };
        colors = themes.modusOperandi;
        cursor = {
          style = {
            shape = "Block";
            blinking = "Off";
          };
          unfocused_hollow = true;
          thickness = 0.15;
        };
        mouse.hide_when_typing = true;
        selection.save_to_clipboard = true;
        general.live_config_reload = true;
      };
    };
  };
}
