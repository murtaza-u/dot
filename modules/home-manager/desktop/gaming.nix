{ pkgs, config, lib, ... }:

{
  options = {
    desktop.gaming.enable = lib.mkEnableOption "Setup gaming";
  };

  config = lib.mkIf config.desktop.gaming.enable {
    home.packages = with pkgs; [
      gamescope
      mangohud
      heroic
      gamemode
    ];
    programs.retroarch = {
      enable = true;
      settings = {
        menu_driver = "xmb";
      };
      cores = {
        pcsx2 = {
          enable = true;
          package = pkgs.libretro.pcsx2;
        };
        ppsspp = {
          enable = true;
          package = pkgs.libretro.ppsspp;
        };
      };
    };
  };
}
