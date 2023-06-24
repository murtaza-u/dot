{ ... }:

{
  services.polybar = {
    enable = true;
    script = "polybar &";
    settings = rec {
      colors = {
        background = "#fafafa";
        foreground = "#383a42";
        black = "#383a42";
        red = "#e45649";
        green = "#50a14f";
        yellow = "#c18401";
        blue = "#0184bc";
        magenta = "#a626a4";
        cyan = "#0997b3";
        white = "#fafafa";
      };
      "global/wm" = {
        margin-bottom = 5;
        margin-top = 5;
      };
      "bar/main" = {
        width = "100%";
        height = 25;
        offset-y = 0;
        top = true;
        fixed-center = true;
        wm-restack = "bspwm";
        override-redirect = true;
        enable-ipc = false;
        background = "${colors.background}";
        foreground = "${colors.foreground}";
        font-0 = "Roboto:style=Medium:size=11.5;2";
        font-1 = "Roboto:style=Bold:size=11.5;2";
        font-2 = "Font Awesome 6 Free Solid:style=Solid:pixelsize=12";
        tray-position = "right";
        tray-maxsize = 18;
        tray-padding = 5;
        cursor-click = "pointer";
        modules-left = "bspwm xwindow";
        modules-center = "date";
        modules-right = "pulseaudio battery wlan";
      };
      settings = {
        screenchange-reload = true;
        format-padding = 1;
      };
      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:40:...%";
      };
      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "AC0";
        poll-interval = 5;
        label-discharging = "BAT: %percentage%%";
        label-charging = "Charging: %percentage%%";
        label-full = "BAT: 100%";
        label-padding = 1;
      };
      "module/bspwm" = {
        type = "internal/bspwm";
        format = "<label-state> <label-mode>";

        label-focused = "%index%";
        label-focused-foreground = "${colors.foreground}";
        label-focused-padding = 2;

        label-occupied = "%index%";
        label-occupied-foreground = "${colors.blue}";
        label-occupied-padding = 2;

        label-urgent = "%index%";
        label-urgent-foreground = "${colors.red}";
        label-urgent-padding = 2;

        label-empty = "%index%";
        label-empty-foreground = "${colors.background}";
        label-empty-padding = 2;
      };
      "module/date" = {
        type = "internal/date";
        interval = 1;
        time = "%a, %b %d %H:%M";
        format = "<label>";
        format-padding = 1;
        label = "%{T1%time%%{T-}";
        label-padding = 1;
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        use-ui-max = false;
        label-volume = "%{T1}Vol: %percentage%%%{T-}";
        label-volume-padding = 1;
        label-muted = "%{T1}Muted%{T-}";
        label-muted-padding = 1;
        click-left = "pavucontrol &";
      };
      "module/wlan" = {
        type = "internal/network";
        interface = "wlp1s0";
        interval = 3.0;
        label-connected = "WiFi: %essid%";
        label-connected-padding = 1;
        format-disconnected = "<label-disconnected>";
        format-disconnected-padding = 1;
        label-disconnected = "WiFi: Down";
        label-disconnected-foreground = "${colors.red}";
        label-disconnected-padding = 1;
      };
    };
  };
}
