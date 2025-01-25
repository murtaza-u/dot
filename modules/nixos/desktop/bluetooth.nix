{ config, lib, ... }:

{
  options = {
    desktop.bluetooth.enable = lib.mkEnableOption "Enable bluetooth";
  };

  config = lib.mkIf config.desktop.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = config.desktop.plasma.enable == false;
  };
}
