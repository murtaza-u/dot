{ config, lib, pkgs, ... }: with lib;

{
  environment.systemPackages = with pkgs.xfce // pkgs; [
    glib # for gsettings
    gtk3.out # gtk-update-icon-cache

    gnome.gnome-themes-extra
    xfce4-icon-theme

    desktop-file-utils
    shared-mime-info # for update-mime-database

    # For a polkit authentication agent
    polkit_gnome

    # Needed by Xfce's xinitrc script
    # Update user dirs as described in
    # https://freedesktop.org/wiki/Software/xdg-user-dirs/
    xdg-user-dirs

    exo
    garcon
    libxfce4ui
    xfce4-notifyd
    xfce4-screenshooter
    xfce4-session
    xfce4-settings
    xfwm4
    xfwm4-themes
    xfce4-panel
    xfdesktop
    xfce4-screensaver
  ] # TODO: NetworkManager doesn't belong here
  ++ optional config.networking.networkmanager.enable networkmanagerapplet
  ++ optional config.powerManagement.enable xfce4-power-manager
  ++ optionals config.hardware.pulseaudio.enable [
    pavucontrol
    xfce4-pulseaudio-plugin
  ];

  programs.xfconf.enable = true;
  programs.thunar.enable = true;

  environment.pathsToLink = [
    "/share/xfce4"
    "/lib/xfce4"
    "/share/gtksourceview-3.0"
    "/share/gtksourceview-4.0"
  ];

  services.xserver.desktopManager.session = [{
    name = "xfce";
    desktopNames = [ "XFCE" ];
    bgSupport = true;
    start = ''
      ${pkgs.runtimeShell} ${pkgs.xfce.xfce4-session.xinitrc} &
      waitPID=$!
    '';
  }];

  services.xserver.updateDbusEnvironment = true;
  services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  # Enable helpful DBus services.
  services.udisks2.enable = true;
  security.polkit.enable = true;
  services.accounts-daemon.enable = true;
  services.upower.enable = config.powerManagement.enable;
  services.gnome.glib-networking.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Enable default programs
  programs.dconf.enable = true;

  # Shell integration for VTE terminals
  programs.bash.vteIntegration = mkDefault true;
  programs.zsh.vteIntegration = mkDefault true;

  # Systemd services
  systemd.packages = with pkgs.xfce; [
    xfce4-notifyd
  ];

  security.pam.services.xfce4-screensaver.unixAuth = true;
}
