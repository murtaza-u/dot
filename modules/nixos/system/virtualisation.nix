{ pkgs, config, lib, ... }:

{
  options = {
    system.virtualisation.docker.enable = lib.mkEnableOption "Enable docker";
    system.virtualisation.libvirtd.enable = lib.mkEnableOption "Enable libvirtd";
  };

  config = {
    virtualisation = {
      docker = lib.mkIf config.system.virtualisation.docker.enable {
        enable = true;
        rootless.enable = true;
        autoPrune = {
          enable = true;
          dates = "weekly";
          flags = [ "-f" ];
        };
        daemon.settings = {
          insecure-registries = [ ];
        };
      };
      libvirtd.enable = config.system.virtualisation.libvirtd.enable;
    };
    environment = lib.mkIf config.system.virtualisation.libvirtd.enable {
      systemPackages = with pkgs; [ virt-manager ];
    };
  };
}
