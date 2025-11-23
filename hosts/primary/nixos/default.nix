{ pkgs, hostName, ... }:

{
  imports = [ ./hardware.nix ];

  # GRUB
  boot.loader.efi = {
    efiSysMountPoint = "/boot/efi";
    canTouchEfiVariables = true;
  };
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    configurationLimit = 20;
    device = "nodev";
    useOSProber = true; # dual-boot with windows
  };

  networking = {
    inherit hostName;
    networkmanager = {
      enable = true;
      insertNameservers = [ "1.1.1.3" "1.0.0.3" ];
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Display drivers
  services.xserver.videoDrivers = [ "modesetting" ];

  # Users on the system.
  users.users.murtaza = {
    isNormalUser = true;
    initialPassword = "ihatenix";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "libvirtd"
      "wireshark"
    ];
  };

  # Enable docker & libvirtd.
  system.virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  # Tailscale.
  system.tailscale.enable = true;

  # Desktop environment & necessary settings.
  desktop = {
    recommended = {
      enable = true;
      ssd = true;
    };
    bluetooth.enable = true;
    plasma.enable = true;
  };

  # Cross-compilation.
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Gaming.
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      # https://github.com/NixOS/nixpkgs/issues/25444
      package = pkgs.steam.override {
        extraPkgs = p: [ p.kdePackages.breeze ];
      };
      gamescopeSession.enable = true;
    };
  };

  system.stateVersion = "25.05";
}
