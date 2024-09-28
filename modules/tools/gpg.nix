{ pkgs, config, lib, ... }:

{
  options = {
    tools.gpg.enable = lib.mkEnableOption "Enable gpg";
  };

  config = lib.mkIf config.tools.gpg.enable {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };
  };
}
