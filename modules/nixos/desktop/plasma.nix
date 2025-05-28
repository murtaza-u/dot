{ pkgs, config, lib, ... }:

{
  options = {
    desktop.plasma.enable = lib.mkEnableOption "Enable KDE Plasma";
  };

  config = lib.mkIf config.desktop.plasma.enable {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    environment.plasma6.excludePackages = with pkgs // pkgs.kdePackages; [
      konsole
      ark
      gwenview
      okular
      kate
      khelpcenter
      krdp
      discover
    ];
  };
}
