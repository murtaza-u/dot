{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./xfce.nix
  ];

  # enable flakes and nix command
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.efi = {
    efiSysMountPoint = "/boot/efi";
    canTouchEfiVariables = true;
  };
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    configurationLimit = 20;
    # Define on which hard drive you want to install Grub.
    device = "nodev"; # or "nodev" for efi only
    useOSProber = true;
  };

  networking = {
    hostName = "workstation";
    networkmanager = {
      enable = true;
      insertNameservers = [ "1.1.1.1" "8.8.8.8" ];
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "ter-u28n";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # fonts = {
  #   fontDir.enable = true;
  #   enableDefaultPackages = true;
  #   packages = with pkgs; [
  #     roboto
  #     iosevka
  #     noto-fonts-emoji
  #   ];
  #   fontconfig = {
  #     enable = true;
  #     hinting.style = "full";
  #     cache32Bit = true;
  #     allowBitmaps = true;
  #     useEmbeddedBitmaps = true;
  #     defaultFonts = {
  #       serif = [ "Roboto" ];
  #       sansSerif = [ "Roboto" ];
  #       monospace = [ "Iosevka" ];
  #       emoji = [ "Noto Color Emoji" ];
  #     };
  #   };
  # };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];

    # Configure keymap in X11
    layout = "us";
    xkbOptions = "caps:escape"; # map caps to escape.

    # Enable touchpad support (enabled default in most desktopManager).
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        disableWhileTyping = true;
        clickMethod = "clickfinger";
      };
    };

    # desktopManager.xfce.enable = true;
    displayManager = {
      defaultSession = "xfce";
      autoLogin = {
        enable = true;
        user = "murtaza";
      };
      lightdm = {
        enable = true;
        greeter.enable = false;
      };
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;

  # Bluetooth.
  hardware.bluetooth.enable = false;
  services.blueman.enable = false;

  # Video support.
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.driSupport = true;

  # Firmware
  hardware.firmware = with pkgs; [ firmwareLinuxNonfree ];
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  # Enable firmware update service
  services.fwupd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.murtaza = {
    isNormalUser = true;
    initialPassword = "ihatenix";
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "docker"
      "networkmanager"
      "libvirtd"
      "wireshark"
    ];
    packages = [
      (import ./scripts/youtube.nix { inherit pkgs; })
      (import ./scripts/docx2pdf.nix { inherit pkgs; })
      (import ./scripts/qrfromimg.nix { inherit pkgs; })
      (import ./scripts/fish.nix { inherit pkgs; })
      (import ./scripts/figl.nix { inherit pkgs; })
      (import ./scripts/whichkey.nix { inherit pkgs; })
      (import ./scripts/ex.nix { inherit pkgs; })
    ];
  };

  # List packages installed in system profile.
  # To search, run:
  #     $ nix search wget
  # environment.systemPackages = with pkgs; [ ];
  environment.defaultPackages = with pkgs; [ nvi ];

  # List services that you want to enable:
  services.openssh.enable = false; # OpenSSH daemon.
  services.fstrim.enable = true;

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 5000 ];
    # allowedUDPPorts = [ ];
  };
}
