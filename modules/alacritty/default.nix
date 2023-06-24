{ ... }:

{
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
          family = "IosevkaTerm Nerd Font";
          style = "Medium";
        };
        bold = {
          family = "IosevkaTerm Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "IosevkaTerm Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "IosevkaTerm Nerd Font";
          style = "Bold Italic";
        };
        size = 12;
      };
      colors = {
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
}
