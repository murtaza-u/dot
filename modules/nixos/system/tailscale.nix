{ config, lib, ... }:

{
  options = {
    system.tailscale.enable = lib.mkEnableOption "Enable tailscaled";
  };

  config = lib.mkIf config.system.tailscale.enable {
    services.tailscale = {
      enable = true;
      disableTaildrop = true;
    };
  };
}
