{ pkgs, inputs, lib, ... }:
{
  home-manager.users.kamasarugo = {
    home.stateVersion = "24.11";
    # import the home manager module
    imports = [
      inputs.noctalia.homeModules.default
    ];

    # configure options
    programs.noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here
        appLauncher = {
          autoPasteClipboard = true;
          clipboardWrapText = true;
          customLaunchPrefix = "";
          customLaunchPrefixEnabled = false;
          enableClipPreview = true;
          enableClipboardHistory = false;
          iconMode = "tabler";
          ignoreMouseInput = false;
          pinnedApps = [
            "floorp"
            "spotify"
            "Prism_Launcher"
            ];
          position = "centre";
          ScreenshotAnnotationTool = "";
          showCategories = true;
          showIconBackground = true;
          sortByMostUsed = true;
          terminalCommand = "noctoria-launcher";
          useApp2Unit = false;
          viewMode = "list";
          };

        bar = {
          backgroundOpacity = lib.mkForce 0.93;
          capsuleOpacity = 1.0;
          density = "default";
          exclusive = true;
          floating = true;
          marginHorizontal = 5;
          marginVertical = 5;
          monitors = [
            
          ];
          outerCorners = false;
          position = "top";
          showCapsule = true;
          showOutline = false;
          useSeperateOpacity = false;
          widgets = {
            center = [
              {
                characterCount = 2;
                colorizeIcons = false;
                enableScrollWheel = true;
                followFocusedScreen = false;
                groupedBorderOpacity = 1;
                hideUnoccupied = false;
                iconeScale = 0.8;
                id = "Workspace";
                labelMode = "none";
                showApplication = false;
                showLabelsOnlyWhenOccupied = false;
                unfocusedIconsOpacity = 1;
                }
              {
                defaultSettings = {
                  hideInactive = false;
                  removeMargins = false;
                };
              }
              {
                id = "plugin:todo";
              }
            ];
            
            left = [
              {
                customFont = "";
                formatHorizontal = "MMMM dd, h:mm ";
                formatVertical = "HH mm - ddd, MMM dd";
                id = "Clock";
                tooltipFormat = "HH:mm ddd, MMM dd";
                useCustomFont = false;
                usePrimaryColor = false;
                }
              {
                compactMode = false;
                diskPath = "/";
                id = "SystemMonitor";
                showCpuTemp = true;
                showCpuUsage = true;
                showDiskUsage = true;
                showGpuTemp = false;
                showLoadAverage = false;
                showMemoryAsPercent = true;
                showMemoryUsage = true;
                showNetworkStats = false;
                useMonospaceFont = true;
                usePrimaryColor = false;
                }
              {
                compactMode = false;
                compactShowAlbumArt = true;
                compactShowVisualizer = false;
                hideMode = "hidden";
                hideWhenIdle = false;
                id = "MediaMini";
                maxWidth = 145;
                panelShowAlbumArt = true;
                panelShowVisualizer = true;
                scrollingMode = "hover";
                showAlbumArt = false;
                showArtistFirst = true;
                showProgressRing = true;
                showVisualizer = true;
                useFixedWidth = false;
                visualizerType = "linear";
                }
              {
                colorizeIcons = false;
                hideMode = "hidden";
                id = "ActiveWindow";
                maxWidth = 145;
                scrollingMode = "hover";
                showIcon = true;
                useFixedWidth = false;
                }
              ];
             
             right = [
              {
                id = "plugin:timer";
                }
              {
                id = "WallpaperSelector";
                }
              {
                displayMode = "onhover";
                id = "Bluetooth";
                }
              {
                displayMode = "onhover";
                id = "Network";
                }
              {
                displayMode = "onhover";
                id = "Volume";
                middleClickCommand = "pwvucontrol || pavucontrol";
                }
              {
                displayMode = "onhover";
                id = "NotificationHistory";
                }
              {
                deviceNativePath = "";
                displayMode = "alwaysShow";
                hideIfNotDetected = true;
                id = "Battery";
                showNoctaliaPerformance = false;
                showPowerProfiles = true;
                warningThreshold = 30;
                }
              {
                colorizeDistroLogo = true;
                colorizeSystemIcon = "none";
                customIconPath = "";
                enableColorization = false;
                icon = "niri";
                id = "ControlCenter";
                useDistroLogo = true;
                }
              ];
            };
          };

        brightness = {
          brightnessStep = 5;
          EnableDdcSupport = false;
          enforceMinimum = true;
          };
        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
              }
            {
              enabled = true;
              id = "calendar-month-card";
              }
            {
              enabled = true;
              id = "timer-card";
              }
            {
              enabled = true;
              id ="weather-card";
              }
            ];
          };
        
        colorSchemes = {
          darkMode = true;
          manualSunrise = "06:30";
          manualSunset = "18:30";
          matugenSchemeType = "scheme-fruit-salad";
          predefinedScheme = "Monochrome";
          schedulingMode = "off";
          useWallpaperColors = false;
          };

        controlCenter = {
         cards = [
          {
            enabled = true;
            id = "profile-card";
            }
          {
            enabled = true;
            id = "shortcuts-card";
            }
          {
            enabled = true;
            id = "audio-card";
            }
          {
            enabled = true;
            id = "weather-card";
            }
          {
            enabled = true;
            id = "media-sysmon-card";
            }
          {
            enabled = true;
            id = "brightness-card";
            }
          ];
        
        diskPath = "/";
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {
              id = "WiFi";
              }
            {
              id = "Bluetooth";
              }
            {
              id = "WallpaperSelector";
              }
            ];
            
          right = [
            {
              id = "Notifications";
              }
            {
              id = "PowerProfile";
              }
            {
              id = "KeepAwake";
              }
            {
              id = "NightLight";
              }
            ];
          };
        };

        desktopWidgets = {
          enabled = false;
          gridSnap = false;
          monitorWidgets = [
            {
              name = "eDP-1";
                widgets = [
                  {
                    clockStyle = "analog";
                      customFont = "";
                      format = "HH:mm\\nd MMMM yyyy";
                      id = "Clock";
                      showBackground = true;
                      useCustomFont = false;
                      usePrimaryColor = false;
                      x = 50;
                      y = 50;
                      }
                    {
                      hideMode = "visible";
                        id = "MediaPlayer";
                        showBackground = true;
                        visualizerType = "linear";
                        x = 100;
                        y = 200;
                        }
                      ];
                    }
                  ];
                };
        dock = {
          animationSpeed = 1;
          backgroundOpacity = 1.0;
          colorizeIcons = false;
          deadOpacity = 0.6;
          displayMode = "auto_hide";
          enabled = true;
          floatingRatio = 1;
          inactiveIndicators = false;
          monitors = [
            ];
          onlySameOutput = true;
          pinnedApps = [
            ];
          pinnedStatic = false;
          position = "bottom";
          size = 1;
          };
          
        general = {
          allowPanelsOnScreenWithoutBar = true;
          animationDisabled = false;
          animationSpeed = 1;
          #avatarImage = "/home/kamasarugo/;
          boxRadiusRatio = 1;
          compactLockScreen = false;
          dimmerOpacity = 0.6;
          enableShadows = true;
          forceBlackScreenCorners = false;
          iRadiusRatio = 1;
          language = "";
          lockOnSuspend = true;
          radiusRatio = 1;
          scaleRatio = 1;
          screenRadiusRatio = 1;
          shadowDirection = "bottom_right";
          shadowOffsetX = 2;
          shadowOffsetY = 3;
          showChangelogOnStartup = true;
          showHibernateOnLockScreen = false;
          showScreenCorners = false;
          showSessionButtonsOnLockScreen = true;
          };
          
        hooks = {
          darkModeChange = "";
          enabled = false;
          performanceModeDisabled = "";
          performanceModeEnabled = "";
          screenLock = "";
          screenUnlock = "";
          wallpaperChange = "";
          };
        location = {
          analogClockInCalendar = true;
          firstDayOfWeek = -1;
          hideWeatherCityName = false;
          hideWeatherTimezone = false;
          name = "Brisbane, Australia";
          showCalendarEvents = true;
          showCalendarWeather = true;
          showWeekNumberInCalendar = false;
          use12hourFormat = false;
          useFahrenheit = false;
          weatherEnabled = true;
          weatherShowEffects = true;
          };
        network = {
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
          bluetoothRssiPollIntervalMs = 10000;
          bluetoothRssiPollingEnabled = false;
          wifiDetailsViewMode = "grid";
          wifiEnabled = true;
          };
        nightLight = {
          autoSchedule = true;
          dayTemp = "6500";
          enabled = false;
          forced = false;
          manualSunrise = "06:30";
          manualSunset = "18:30";
          nightTemp = "4000";
          };
        notifications = {
          backgroundOpacity = 1.0;
          criticalUrgencyDuration = 15;
          enableKeyboardLayoutToast = true;
          enabled = true;
          location = "top_right";
          lowUrgencyDuration = 3;
          monitors = [
            ];
          normalUrgencyDuration = 8;
          overlayLayer = true;
          respectExpireTimeout = false;
          saveToHistory = {
            critical = true;
            low = true;
            normal = true;
            };
            sounds = {
              criticalSoundFile = "";
              enabled = false;
              excludedApps = "vesktop,firefox,chrome,chromium";
              lowSoundFile = "";
              normalSoundFile = "";
              separateSounds = false;
              volume = 0.5;
              };
            };
        osd = {
          autoHideMs = 2000;
          backgroundOpacity = 1.0;
          enabled = true;
          enabledTypes = [
            0
            1
            2
          ];
          location = "top_right";
          monitors = [
          ];
          overlayLayer = true;
          };

        sessionMenu = {
          countdownDuration = 10000;
          enableCountdown = true;
          largeButtonsLayout = "grid";
          largeButtonsStyle = false;
          position = "center";
          powerOptions = [
            {
              action = "lock";
              command = "";
              countdownEnabled = true;
              enabled = true;
              }
            {
              action = "suspend";
              command = "";
              countdownEnabled = true;
              enabled = true;
              }
            {
              action = "hibernate";
              command = "";
              countdownEnabled = true;
              enabled = false;
              }
            {
              action = "reboot";
              command = "";
              countdownEnabled = true;
              enabled = true;
              }
            {
              action = "logout";
              command = "";
              countdownEnabled = true;
              enabled = true;
              }
            {
              action = "shutdown";
              command = "";
              countdownEnabled = true;
              enabled = true;
              }
            ];
          showHeader = true;
          showNumberLabels = true;
          };

          settingsVersion = 39;
          systemMonitor = {
            cpuCriticalThreshold = 90;
            cpuPollingInterval = 3000;
            cpuWarningThreshold = 80;
            criticalColor = "";
            diskCriticalThreshold = 90;
            diskPollingInterval = 3000;
            diskWarningThreshold = 80;
            enableDgpuMonitoring = false;
            #externalMonitor": "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor",
            gpuCriticalThreshold = 90;
            gpuPollingInterval = 3000;
            gpuWarningThreshold = 80;
            loadAvgPollingInterval = 3000;
            memCriticalThreshold = 90;
            memPollingInterval = 3000;
            memWarningThreshold = 80;
            networkPollingInterval = 3000;
            tempCriticalThreshold = 90;
            tempPollingInterval = 3000;
            tempWarningThreshold = 80;
            useCustomColors = false;
            warningColor = "";
            };

        templates = {
          alacritty = false;
          enableUserTemplates = false;
          fuzzel = false;
          gtk = false;
          helix = false;
          kitty = false;
          niri = false;
          qt = false;
          zenBrowser = true;
          };

        ui = {
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
          boxBorderEnabled = false;
          ontDefault = "Inter Variable";
          fontDefaultScale = 1;
          fontFixed = lib.mkForce "JetBrainsMono Nerd Font Mono";
          fontFixedScale = 1;
          networkPanelView = "wifi";
          panelBackgroundOpacity = 1.0;
          panelsAttachedToBar  = true;
          settingsPanelMode = "attached";
          tooltipsEnabled = true;
          wifiDetailsViewMode = "grid";
          };

        wallpaper = {
          directory = "../../wallpapers";
          enableMultiMonitorDirectories = false;
          enabled = true;
          fillColor = "#000000";
          fillMode = "crop";
          hideWallpaperFilenames = false;
          monitorDirectories = [
          ];
          overviewEnabled = false;
          panelPosition = "top_center";
          randomEnabled = false;
          randomIntervalSec = 300;
          recursiveSearch = false;
          setWallpaperOnAllMonitors = true;
          solidColor = "#1a1a2e";
          transitionDuration = 1500;
          transitionEdgeSmoothness = 0.05;
          transitionType = "random";
          useSolidColor = false;
          useWallhaven = false;
          wallhavenApiKey = "";
          wallhavenCategories = "111";
          wallhavenOrder = "desc";
          wallhavenPurity = "100";
          wallhavenQuery = "";
          wallhavenRatios = "";
          wallhavenResolutionHeight = "";
          wallhavenResolutionMode = "atleast";
          wallhavenResolutionWidth = "";
          wallhavenSorting = "relevance";
          wallpaperChangeMode = "random";
          };
        };
      # this may also be a string or a path to a JSON file.
      };
    };
  }
