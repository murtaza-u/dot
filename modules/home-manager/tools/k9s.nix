{ config, lib, ... }:

{
  options = {
    tools.k9s.enable = lib.mkEnableOption "Enable k9s";
  };

  config = lib.mkIf config.tools.k9s.enable {
    programs.k9s = {
      enable = true;
      settings.k9s = {
        ui.skin = "modusOperandi";
      };
      skins = {
        modusOperandi.k9s = {
          body = {
            fgColor = "#000000";
            bgColor = "#f6f5f4";
            logoColor = "#8839ef";
          };
          prompt = {
            fgColor = "#000000";
            bgColor = "#f6f5f4";
            suggestColor = "#0031a9";
          };
          help = {
            fgColor = "#000000";
            bgColor = "#f6f5f4";
            sectionColor = "#000000";
            keyColor = "#0031a9";
            numKeyColor = "#ff8f88";
          };
          frame = {
            title = {
              fgColor = "#0031a9";
              bgColor = "#f6f5f4";
              highlightColor = "#000000";
              counterColor = "#884900";
              filterColor = "#4faa09";
            };
            border = {
              fgColor = "#193668";
              focusColor = "#f0e0cc";
            };
            menu = {
              fgColor = "#4c4f69";
              keyColor = "#0031a9";
              numKeyColor = "#d00000";
            };
            crumbs = {
              fgColor = "#f6f5f4";
              bgColor = "#d00000";
              activeColor = "#7f0000";
            };
            status = {
              newColor = "#0031a9";
              modifyColor = "#7090ff";
              addColor = "#4faa09";
              pendingColor = "#ffcf00";
              errorColor = "#d20f39";
              highlightColor = "#04a5e5";
              killColor = "#8839ef";
              completedColor = "#9ca0b0";
            };
          };
          info = {
            fgColor = "#000000";
            sectionColor = "#4c4f69";
          };
          views = {
            table = {
              fgColor = "#000000";
              bgColor = "#f6f5f4";
              cursorFgColor = "#f0f0f0";
              cursorBgColor = "#bcc0cc";
              markColor = "#dc8a78";
              header = {
                fgColor = "#000000";
                bgColor = "#f6f5f4";
                sorterColor = "#f0f0f0";
              };
            };
            xray = {
              fgColor = "#4c4f69";
              bgColor = "#eff1f5";
              cursorColor = "#bcc0cc";
              cursorTextColor = "#eff1f5";
              graphicColor = "#dd22dd";
            };
            charts = {
              bgColor = "#f6f5f4";
              chartBgColor = "#f6f5f4";
              dialBgColor = "#f6f5f4";
              defaultDialColors = [ "#4faa09" "#d20f39" ];
              defaultChartColors = [ "#4faa09" "#d20f39" ];
              resourceColors = {
                cpu = [ "#8839ef" "#0031a9" ];
                mem = [ "#884900" "#ffcf00" ];
              };
            };
            yaml = {
              keyColor = "#0031a9";
              valueColor = "#4c4f69";
              colonColor = "#6c6f85";
            };
            logos = {
              fgColor = "#000000";
              bgColor = "#f6f5f4";
              indicator = {
                fgColor = "#0031a9";
                bgColor = "#f6f5f4";
                toggleOnColor = "#4faa09";
                toggleOffColor = "#6c6f85";
              };
            };
          };
          dialog = {
            fgColor = "#193668";
            bgColor = "#f0f0f0";
            buttonFgColor = "#eff1f5";
            buttonBgColor = "#8c8fa1";
            buttonFocusFgColor = "#0031a9";
            buttonFocusBgColor = "#dd22dd";
            labelFgColor = "#dc8a78";
            fieldFgColor = "#4c4f69";
          };
        };
      };
    };
  };
}
