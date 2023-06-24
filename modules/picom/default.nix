{ ... }:

{
  services.picom = {
    enable = true;
    activeOpacity = 1.0;
    fade = false;
    fadeDelta = 5;
    fadeExclude = [ "class_g = 'Rofi'" ];
    fadeSteps = [ 0.03 0.03 ];
    shadow = true;
  };
}
