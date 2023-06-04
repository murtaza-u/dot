{ lib, pkgs, config, modulesPath, ... }:

with lib;
let
  nixos-wsl = import ./nixos-wsl;
in
{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
    nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "murtaza";
    startMenuLaunchers = true;
    docker-native.enable = true;
  };

  # enable flakes and nix command
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.murtaza = {
    isNormalUser = true;
    initialPassword = "ihatenix";
    extraGroups = [ "wheel" "video" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = [ ];
  };

  networking.dhcpcd.enable = false;

  environment.etc.hosts.enable = false;
  environment.etc."resolv.conf".enable = false;
  environment.defaultPackages = with pkgs; [ nvi ];
  environment.systemPackages = with pkgs; [ ];

  # Disable systemd units that don't make sense on WSL
  systemd.services."serial-getty@ttyS0".enable = false;
  systemd.services."serial-getty@hvc0".enable = false;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@".enable = false;
  systemd.services.firewall.enable = false;
  systemd.services.systemd-resolved.enable = false;
  systemd.services.systemd-udevd.enable = false;
  # Don't allow emergency mode, because we don't have a console.
  systemd.enableEmergencyMode = false;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";
}
