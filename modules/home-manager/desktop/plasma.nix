{ pkgs, config, lib, ... }:
let
  wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/ScarletTree/contents/images/5120x2880.png";
in
{
  options = {
    desktop.plasma = {
      enable = lib.mkEnableOption "Setup KDE Plasma desktop environment";
      overrideExistingConfig = lib.mkOption {
        type = lib.types.bool;
        description = "Override existing Plasma config";
        default = false;
      };
    };
  };

  config = lib.mkIf config.desktop.plasma.enable {
    programs.plasma = {
      enable = true;
      overrideConfig = config.desktop.plasma.overrideExistingConfig;
      powerdevil = {
        general.pausePlayersOnSuspend = true;
        batteryLevels = {
          criticalLevel = 3;
          lowLevel = 10;
          criticalAction = "hibernate";
        };
        AC = {
          autoSuspend.action = "nothing";
          dimDisplay = {
            enable = true;
            idleTimeout = 300; # 5min
          };
          powerProfile = "performance";
          turnOffDisplay.idleTimeout = "never";
          whenLaptopLidClosed = "sleep";
          whenSleepingEnter = "standby";
        };
        battery = {
          autoSuspend.action = "nothing";
          dimDisplay = {
            enable = true;
            idleTimeout = 120; # 2min
          };
          powerProfile = "balanced";
          turnOffDisplay.idleTimeout = "never";
          whenLaptopLidClosed = "sleep";
          whenSleepingEnter = "standbyThenHibernate";
        };
        lowBattery = {
          autoSuspend.action = "nothing";
          dimDisplay = {
            enable = true;
            idleTimeout = 60; # 1min
          };
          powerProfile = "powerSaving";
          turnOffDisplay.idleTimeout = "never";
          whenLaptopLidClosed = "sleep";
          whenSleepingEnter = "standbyThenHibernate";
        };
      };
      workspace = {
        theme = "breeze-light";
        colorScheme = "BreezeClassic";
        lookAndFeel = "org.kde.breeze.desktop";
        cursor = {
          theme = "breeze_cursors";
          size = 24;
        };
        iconTheme = "breeze";
        wallpaper = wallpaper;
      };
      kscreenlocker.autoLock = false;
      fonts = rec {
        fixedWidth = {
          family = "ZedMono Nerd Font";
          pointSize = 11;
        };
        general = {
          family = "Roboto Condensed";
          pointSize = 11;
        };
        small = {
          family = "Roboto Condensed";
          pointSize = 10;
        };
        toolbar = general;
        menu = general;
        windowTitle = general;
      };
      hotkeys.commands = {
        "spectacle" = {
          name = "Spectacle Screenshot";
          key = "Meta+Shift+S";
          command = "${pkgs.kdePackages.spectacle}/bin/spectacle -r";
          logs.enabled = false;
        };
      };
      input = {
        keyboard = {
          repeatDelay = 200;
          repeatRate = 60;
        };
        mice = [
          {
            name = "PixArt Dell MS116 USB Optical Mouse";
            enable = true;
            productId = "301a";
            vendorId = "413c";
            acceleration = 0.4;
            accelerationProfile = "none";
            leftHanded = false;
            middleButtonEmulation = false;
            naturalScroll = false;
            scrollSpeed = 1.5;
          }
        ];
        touchpads = [
          {
            name = "ELAN1301:00 04F3:30C6 Touchpad";
            enable = true;
            productId = "30c6";
            vendorId = "04f3";
            disableWhileTyping = true;
            leftHanded = false;
            middleButtonEmulation = true;
            naturalScroll = true;
            pointerSpeed = 0.2;
            tapToClick = true;
            tapAndDrag = true;
            tapDragLock = true;
            scrollMethod = "twoFingers";
            rightClickMethod = "twoFingers";
            scrollSpeed = 0.3;
            twoFingerTap = "rightClick";
          }
        ];
      };
      kwin = {
        edgeBarrier = 0; # disables the edge-barriers introduced in plasma 6.1
        cornerBarrier = false;
        borderlessMaximizedWindows = true;
        effects = {
          wobblyWindows.enable = false;
          desktopSwitching.animation = "slide";
          minimization = {
            animation = "magiclamp";
            duration = 250; # in ms
          };
          windowOpenClose.animation = "scale";
        };
        nightLight = {
          enable = true;
          mode = "times";
          temperature = {
            day = 6500;
            night = 5500;
          };
          time = {
            evening = "19:00";
            morning = "07:00";
          };
          transitionTime = 60;
        };
        titlebarButtons = {
          left = [ "on-all-desktops" ];
          right = [ "minimize" "maximize" "close" ];
        };
        virtualDesktops = {
          names = [
            "Desktop 1"
            "Desktop 2"
            "Desktop 3"
            "Desktop 4"
          ];
          rows = 1;
        };
      };
      shortcuts = {
        kwin = {
          "Show Desktop" = "Meta+D";
          "Switch to Desktop 1" = "Meta+1";
          "Switch to Desktop 2" = "Meta+2";
          "Switch to Desktop 3" = "Meta+3";
          "Switch to Desktop 4" = "Meta+4";
          "Walk Through Windows" = "Alt+Tab";
          "Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
          "Walk Through Windows of Current Application" = "Alt+`";
          "Walk Through Windows of Current Application (Reverse)" = "Alt+~";
          "Window Close" = "Meta+X";
          "Window Fullscreen" = "Meta+Shift+F";
          "Window Quick Tile Bottom" = "Meta+Down";
          "Window Quick Tile Left" = "Meta+Left";
          "Window Quick Tile Right" = "Meta+Right";
          "Window Quick Tile Top" = "Meta+Up";
          "Window to Desktop 1" = "Meta+!";
          "Window to Desktop 2" = "Meta+@";
          "Window to Desktop 3" = "Meta+#";
          "Window to Desktop 4" = "Meta+$";
          "view_actual_size" = "Meta+0";
          "view_zoom_in" = "Meta+=";
          "view_zoom_out" = "Meta+-";
        };
        "ksmserver"."Log Out" = "Meta+Shift+Q";
        "services/Alacritty.desktop"."New" = "Meta+Return";
        "services/chromium-browser.desktop"."new-private-window" = "Meta+Shift+B";
        "services/chromium-browser.desktop"."new-window" = "Meta+B";
      };
      configFile = {
        "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
        "kdeglobals"."General"."TerminalApplication" = "alacritty";
        "kdeglobals"."General"."TerminalService" = "Alacritty.desktop";
        "kdeglobals"."General"."XftHintStyle" = "hintnone";
        "kdeglobals"."General"."XftSubPixel" = "none";
        "krunnerrc"."General"."FreeFloating" = true;
        "krunnerrc"."Plugins"."baloosearchEnabled" = false;
        "krunnerrc"."Plugins"."browserhistoryEnabled" = false;
        "krunnerrc"."Plugins"."browsertabsEnabled" = false;
        "krunnerrc"."Plugins"."calculatorEnabled" = true;
        "krunnerrc"."Plugins"."helprunnerEnabled" = false;
        "krunnerrc"."Plugins"."krunner_appstreamEnabled" = false;
        "krunnerrc"."Plugins"."krunner_bookmarksrunnerEnabled" = false;
        "krunnerrc"."Plugins"."krunner_charrunnerEnabled" = false;
        "krunnerrc"."Plugins"."krunner_dictionaryEnabled" = false;
        "krunnerrc"."Plugins"."krunner_katesessionsEnabled" = false;
        "krunnerrc"."Plugins"."krunner_killEnabled" = false;
        "krunnerrc"."Plugins"."krunner_konsoleprofilesEnabled" = false;
        "krunnerrc"."Plugins"."krunner_kwinEnabled" = false;
        "krunnerrc"."Plugins"."krunner_placesrunnerEnabled" = false;
        "krunnerrc"."Plugins"."krunner_plasma-desktopEnabled" = false;
        "krunnerrc"."Plugins"."krunner_powerdevilEnabled" = false;
        "krunnerrc"."Plugins"."krunner_recentdocumentsEnabled" = false;
        "krunnerrc"."Plugins"."krunner_sessionsEnabled" = false;
        "krunnerrc"."Plugins"."krunner_shellEnabled" = false;
        "krunnerrc"."Plugins"."krunner_spellcheckEnabled" = false;
        "krunnerrc"."Plugins"."krunner_webshortcutsEnabled" = false;
        "krunnerrc"."Plugins"."locationsEnabled" = false;
        "krunnerrc"."Plugins"."org.kde.activities2Enabled" = false;
        "krunnerrc"."Plugins"."org.kde.datetimeEnabled" = false;
        "krunnerrc"."Plugins"."unitconverterEnabled" = false;
        "krunnerrc"."Plugins"."windowsEnabled" = false;
        "krunnerrc"."Plugins/Favorites"."plugins" = "krunner_services,krunner_systemsettings";
        "kwinrc"."Compositing"."AllowTearing" = false;
        "kwinrc"."Xwayland"."Scale" = 1.25;
        "kwinrc"."TabBox"."HighlightWindows" = false;
        "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
        "plasmanotifyrc"."Notifications"."PopupPosition" = "TopRight";
        "plasmaparc"."General"."GlobalMute" = true;
        "spectaclerc"."GuiConfig"."captureMode" = 0;
        "spectaclerc"."GuiConfig"."includeDecorations" = false;
        "spectaclerc"."GuiConfig"."includePointer" = true;
        "spectaclerc"."GuiConfig"."videoIncludePointer" = true;
        "spectaclerc"."ImageSave"."preferredImageFormat" = "JPEG";
        "spectaclerc"."ImageSave"."translatedScreenshotsFolder" = "Screenshots";
        "spectaclerc"."VideoSave"."preferredVideoFormat" = 2;
        "spectaclerc"."VideoSave"."translatedScreencastsFolder" = "Screencasts";
      };
      dataFile = {
        "dolphin/view_properties/global/.directory"."Dolphin"."SortRole" = "modificationtime";
      };
      panels = [
        {
          alignment = "center";
          floating = false;
          height = 32;
          hiding = "dodgewindows";
          lengthMode = "fill";
          location = "bottom";
          opacity = "adaptive";
          widgets = [
            {
              kickoff = {
                icon = "nix-snowflake";
                sortAlphabetically = false;
                compactDisplayStyle = false;
                sidebarPosition = "left";
                favoritesDisplayMode = "grid";
                applicationsDisplayMode = "list";
                showButtonsFor = "power";
              };
            }
            {
              pager = {
                general = {
                  showWindowOutlines = true;
                  showApplicationIconsOnWindowOutlines = false;
                  showOnlyCurrentScreen = false;
                  navigationWrapsAround = false;
                  displayedText = "none";
                  selectingCurrentVirtualDesktop = "doNothing";
                };
              };
            }
            "org.kde.plasma.colorpicker"
            {
              iconTasks = {
                iconsOnly = true;
                appearance = {
                  showTooltips = true;
                  highlightWindows = true;
                  indicateAudioStreams = true;
                  fill = true;
                  rows = {
                    multirowView = "never";
                  };
                  iconSpacing = "medium";
                };
                behavior = {
                  grouping = {
                    method = "byProgramName";
                    clickAction = "cycle";
                  };
                  sortingMethod = "manually";
                  minimizeActiveTaskOnClick = true;
                  middleClickAction = "newInstance";
                  wheel.switchBetweenTasks = false;
                  showTasks = {
                    onlyInCurrentScreen = true;
                    onlyInCurrentDesktop = true;
                    onlyInCurrentActivity = true;
                    onlyMinimized = false;
                  };
                  unhideOnAttentionNeeded = true;
                  newTasksAppearOn = "right";
                };
              };
            }
            "org.kde.plasma.marginsseparator"
            {
              systemTray.icons = {
                spacing = "small";
                scaleToFit = false;
              };
            }
            {
              digitalClock = {
                date = {
                  enable = false;
                  format = "longDate";
                  position = "besideTime";
                };
                time = {
                  showSeconds = "onlyInTooltip";
                  format = "24h";
                };
                calendar = {
                  firstDayOfWeek = "monday";
                  showWeekNumbers = false;
                  plugins = [ "holidaysevents" "astronomicalevents" ];
                };
              };
            }
            "org.kde.plasma.showdesktop"
          ];
        }
      ];
    };
  };
}
