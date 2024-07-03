let
  themes = {
    oneLight = {
      primary = {
        background = "0xfafafa";
        foreground = "0x383a42";
      };
      normal = {
        black = "0x383a42";
        red = "0xe45649";
        green = "0x50a14f";
        yellow = "0xc18401";
        blue = "0x0184bc";
        magenta = "0xa626a4";
        cyan = "0x0997b3";
        white = "0xfafafa";
      };
      bright = {
        black = "0x383a42";
        red = "0xe45649";
        green = "0x50a14f";
        yellow = "0xc18401";
        blue = "0x0184bc";
        magenta = "0xa626a4";
        cyan = "0x0997b3";
        white = "0xfafafa";
      };
    };
    modusOperandi = {
      primary = {
        background = "0xfafafa";
        foreground = "0x000000";
      };
      normal = {
        black = "0xa9a9a9";
        red = "0xa60000";
        green = "0x006800";
        yellow = "0x6f5500";
        blue = "0x0031a9";
        magenta = "0x721045";
        cyan = "0x005e8b";
        white = "0x000000";
      };
      bright = {
        black = "0x708090";
        red = "0xd00000";
        green = "0x008900";
        yellow = "0x808000";
        blue = "0x0000ff";
        magenta = "0xdd22dd";
        cyan = "0x008899";
        white = "0x595959";
      };
      indexed_colors = [
        {
          index = 16;
          color = "0x884900";
        }
        {
          index = 17;
          color = "0x7f0000";
        }
      ];
    };
    gruvboxDark = {
      primary = {
        background = "0x1d2021";
        foreground = "0xebdbb2";
      };
      normal = {
        black = "0x282828";
        red = "0xcc241d";
        green = "0x98971a";
        yellow = "0xd79921";
        blue = "0x458588";
        magenta = "0xb16286";
        cyan = "0x689d6a";
        white = "0xa89984";
      };
      bright = {
        black = "0x928374";
        red = "0xfb4934";
        green = "0xb8bb26";
        yellow = "0xfabd2f";
        blue = "0x83a598";
        magenta = "0xd3869b";
        cyan = "0x8ec07c";
        white = "0xebdbb2";
      };
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
          size = 12;
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
        live_config_reload = true;
      };
    };
  };
}
