{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

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
    theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
  };

  networking = {
    hostName = "workstation";
    networkmanager = {
      enable = true;
      # cloudflare DNS (blocks malware and adult content)
      insertNameservers = [ "1.1.1.3" "1.0.0.3" ];
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
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];

    # Configure keymap in X11
    xkb = {
      layout = "us";
      options = "caps:escape";
    };

    desktopManager.xfce = {
      enable = true;
      enableScreensaver = true;
    };

    displayManager.lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        theme = {
          name = "Breeeze";
          package = pkgs.breeze-gtk;
        };
        iconTheme = {
          name = "breeze";
          package = pkgs.breeze-icons;
        };
        cursorTheme = {
          name = "breeze_cursors";
          package = pkgs.breeze-icons;
        };
        extraConfig = ''
          background = ${../../store/nixos.png}
        '';
      };
    };
  };

  services.displayManager.defaultSession = "xfce";

  # Enable sound.
  hardware.pulseaudio.enable = true;

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

  users.users.murtaza = {
    isNormalUser = true;
    initialPassword = "ihatenix";
    extraGroups = [
      "wheel"
      "docker"
      "video"
      "audio"
      "networkmanager"
      "libvirtd"
      "wireshark"
    ];
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
        serif = [ "Roboto Medium" ];
        sansSerif = [ "Roboto Medium" ];
        monospace = [ "ZedMono Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [ nvi virt-manager ];
  environment.xfce.excludePackages = with pkgs.xfce // pkgs; [
    mousepad
    parole
    ristretto
    xfce4-terminal
  ];

  # some programs need SUID wrappers, can be configured further or are
  # started in user sessions
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  services.fstrim.enable = true; # SSD
  services.fwupd.enable = true; # firmware update service

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    driSupport = true;
  };

  # Enable bluetooth.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Open ports in the firewall.
  networking.firewall.enable = false;
  # networking.firewall.allowedTCPPorts = [ ];
  # networking.firewall.allowedUDPPorts = [ ];

  # Enable docker and libvirtd
  virtualisation = {
    docker = {
      enable = true;
      rootless.enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [ "-f" ];
      };
    };
    libvirtd.enable = true;
  };
}
