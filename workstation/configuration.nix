# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "ter-u28n";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];

    # windowManager.bspwm.enable = true;
    # displayManager.startx.enable = true;

    desktopManager.xfce.enable = true;
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "xfce";

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
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound and bluetooth.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth = {
    enable = false;
    powerOnBoot = false;
  };
  services.blueman.enable = false;

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
    extraGroups = [ "wheel" "video" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = [ ];
  };

  environment.defaultPackages = with pkgs; [ nvi ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.openssh.enable = false; # OpenSSH daemon.
  security.polkit.enable = true;
  services.tlp.enable = true;
  services.udisks2.enable = true;
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };
  services.fstrim.enable = true;

  /*
    systemd.services = {
    systemd-logind.restartIfChanged = false;
    polkit.restartIfChanged = false;
    display-manager.restartIfChanged = false;
    NetworkManager.restartIfChanged = false;
    wpa_supplicant.restartIfChanged = false;
    lock-before-sleeping = {
      restartIfChanged = false;
      unitConfig = {
        Description = "Helper service to bind locker to sleep.target";
      };
      serviceConfig = {
        ExecStart = "${pkgs.slock}/bin/slock";
        Type = "simple";
      };
      before = [
        "pre-sleep.service"
      ];
      wantedBy = [
        "pre-sleep.service"
      ];
      environment = {
        DISPLAY = ":0";
        XAUTHORITY = "/home/murtaza/.Xauthority";
      };
    };
    };
  */

  virtualisation.docker.enable = true;

  networking.firewall.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 5000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
