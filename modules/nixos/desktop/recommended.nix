{ pkgs, config, lib, ... }:

{
  options = {
    desktop.recommended = {
      enable = lib.mkEnableOption "Enable recommended services";
      ssd = lib.mkEnableOption "Enable recommended configuration for SSD";
    };
  };

  config = lib.mkIf config.desktop.recommended.enable {
    # Provides an organized way for non-privileged processes to communicate
    # with privileged ones.
    security.polkit.enable = true;

    # Firmware update service.
    services.fwupd.enable = true;

    # Helps improve the performance and lifespan of solid-state drives.
    services.fstrim.enable = config.desktop.recommended.ssd;

    # Enable hardware accelerated graphics drivers.
    hardware.graphics.enable = true;

    # some programs need SUID wrappers, can be configured further or are
    # started in user sessions
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    fonts = {
      packages = with pkgs; [
        roboto
        noto-fonts-color-emoji
        (nerdfonts.override { fonts = [ "ZedMono" ]; })
      ];
      fontDir.enable = true;
      fontconfig = {
        enable = true;
        antialias = true;
        hinting.style = "none";
        defaultFonts = {
          serif = [ "Roboto Condensed Medium" ];
          sansSerif = [ "Roboto Condensed Medium" ];
          monospace = [ "ZedMono Nerd Font" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        disableWhileTyping = true;
        clickMethod = "clickfinger";
      };
    };

    # Map capslock to escape.
    services.xserver.xkb = {
      layout = "us";
      options = "caps:escape";
    };
  };
}
