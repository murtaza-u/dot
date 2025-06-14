{ hostName, ... }:

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
      allowedTCPPorts = [ 5000 ];
      allowedUDPPorts = [ ];
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Display drivers
  services.xserver.videoDrivers = [ "amdgpu" ];

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

  # Use your phone as webcam.
  programs.droidcam.enable = true;

  # Enable docker & libvirtd
  system.virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

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

  system.stateVersion = "25.05";
}
