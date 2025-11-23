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
        background = "#f6f5f4";
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
    modusVivendi = {
      primary = {
        background = "#1d2120";
        foreground = "#ffffff";
      };
      normal = {
        black = "#1e1e1e";
        red = "#ff5f59";
        green = "#44bc44";
        yellow = "#d0bc00";
        blue = "#2fafff";
        magenta = "#feacd0";
        cyan = "#00d3d0";
        white = "#ffffff";
      };
      bright = {
        black = "#535353";
        red = "#ff7f9f";
        green = "#00c06f";
        yellow = "#dfaf7a";
        blue = "#00bcff";
        magenta = "#b6a0ff";
        cyan = "#6ae4b9";
        white = "#989898";
      };
      cursor = {
        cursor = "#ffffff";
        text = "#000000";
      };
      selection = {
        background = "#5a5a5a";
        text = "#ffffff";
      };
    };
    gruvboxDark = {
      primary = {
        background = "#282828";
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
    tokyonightNight = {
      primary = {
        background = "#181818";
        foreground = "#c0caf5";
      };
      normal = {
        black = "#15161e";
        red = "#f7768e";
        green = "#9ece6a";
        yellow = "#e0af68";
        blue = "#7aa2f7";
        magenta = "#bb9af7";
        cyan = "#7dcfff";
        white = "#a9b1d6";
      };
      bright = {
        black = "#414868";
        red = "#ff899d";
        green = "#9fe044";
        yellow = "#faba4a";
        blue = "#8db0ff";
        magenta = "#c7a9ff";
        cyan = "#a4daff";
        white = "#c0caf5";
      };
      indexed_colors = [
        {
          index = 16;
          color = "#ff9e64";
        }
        {
          index = 17;
          color = "#db4b4b";
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
