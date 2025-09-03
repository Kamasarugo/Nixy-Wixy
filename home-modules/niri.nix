{ config , pkgs , osConfig, ... }:
let
  mod = "Super";
  menu = "wofi --show drun";
  terminal = "kitty";
  alt_terminal = "foot";

  hostname = osConfig.networking.hostName;

  colors = config.lib.stylix.colors;
in {
  imports = [
    ./waybar.nix # bar
  ];

  services.swaync.enable = true;

  home.packages = with pkgs; [
    ksnip
    playerctl
    swayidle           
    swaylock-effects   
    xwayland-satellite
    pulseaudio # pactl for toggle mute
    pavucontrol
    fish # scripts
    libnotify # some things rely on libnotify to function
  ];
  
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gnome";
  };

  services.hyprpaper.enable = true;

  programs.niri = {
    settings = {
      prefer-no-csd = true;

      spawn-at-startup =[
        { command = [ "sh" "-c" "systemctl --user enable --now syncthingtray.service" ]; }
        { command = [ "sh" "-c" "systemctl --user enable --now hyprpaper.service" ]; }
        { command = [ "sh" "-c" "systemctl --user enable --now waybar.service" ]; }
        { command = [ "xwayland-satellite" ]; }
        { command = [ "foot" "-s" ]; }
        { command = [ "${pkgs.networkmanagerapplet}/bin/nm-applet" "--indicator" ]; }
      ] ++ (
        if hostname == "nixos-desktop" then [
          { command = [ "sh" "-c" "discord --start-minimized" ]; }
          { command = [ "element-desktop" "--hidden" ]; }
          { command = [ "sh" "-c" "steam -silent" ]; }
        ] else []
      );

      environment = {
        QT_QPA_PLATFORM = "wayland";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        DISPLAY = ":0";
        _JAVA_AWT_WM_NONREPARENTING="1";
      };

      input = {

#        focus-follows-mouse.enable = true;
        
        mouse = {
          accel-profile = "flat";
          accel-speed = 0.0;
        };
  
        trackpoint = {
          accel-profile = "adaptive";
          accel-speed = 0.6;
        };

        tablet.map-to-output = "HDMI-A-1";
      };

      layout = {
        always-center-single-column = false;
        empty-workspace-above-first = true;
        border.width = 2;
        gaps = 15;

        shadow = {
          enable = true;
          color = "#${colors.base00}";
        };

        struts =
        let
        side_struts = 15;
        in {
          left = side_struts;
          right = side_struts;
        };
      };


      window-rules = [
        {
          geometry-corner-radius = let
            r = 10.0;
          in {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
          clip-to-geometry = true;
        }
      ];

      outputs = {
        # left desktop monitor
        "HDMI-A-2" = {
          scale = 1.0;
          transform.rotation = 90;
          mode = {
            width = 1680;
            height = 1050;
            };
          position = {
            x = -500;
            y = -500;
          };
        };
      
        # primary desktop monitor
        "DP-1" = {
          scale = 1.0;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 239.964;
            };
            position = {
              x = 0;
              y = 0;
            };
          };

        # laptop monitor
        "eDP-1" = {
          scale = 1.0;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 100.0;
          };
        };
      };
      
      binds = with config.lib.niri.actions;
      let
        # for shell scripts remember to actually run them
        # with fish, see cleddy bind
        fish = spawn "fish" "-c";
      in {
        # misc
        # edit text then save to clipboard
#        "${mod}+Shift+E".action = fish "fish ${../scripts/eddy.fish}";
        # edit clipboard
#        "${mod}+E".action = fish "fish ${../scripts/cleddy.fish}";
        
        # open things
        "${mod}+D".action = fish menu;
        "${mod}+Return".action = fish terminal;
        "${mod}+Shift+Return".action = fish alt_terminal;
        "${mod}+Shift+M".action = quit;
        "${mod}+T".action = fish "bemoji -c -n";
#        "${mod}+P".action = fish "fish ${../scripts/lock-screen.fish}";
#        "${mod}+Shift+C".action = fish "fish ${../scripts/command-runner.fish}";
        "${mod}+N".action = spawn "footclient" "numbat";
        "${mod}+Y".action = fish "notify-send\"$(niri msg focused-window)\"";
        "${mod}+Shift+Y".action = fish "set win (niri msg focused-window); wl-copy $win; notify-send \"$win\"";
        "${mod}+Z".action = spawn "${pkgs.woomer}/bin/woomer";
        "${mod}+V".action = spawn "pavucontrol";

        # reorient
        "${mod}+Q".action = close-window;
        "${mod}+F".action = maximize-column;
        "${mod}+Shift+F".action = fullscreen-window;
        "${mod}+Space".action = toggle-window-floating;
        "${mod}+W".action = toggle-column-tabbed-display;

        # open things but better!!!
#        "${mod}+1".action = spawn "floorp";
#        "${mod}+2".action = spawn "obsidian";
#        "${mod}+3".action = spawn "discord";
#        "${mod}+4".action = spawn "steam";

        # refocus
        "${mod}+K".action = focus-window-or-workspace-up;
        "${mod}+J".action = focus-window-or-workspace-down;
        "${mod}+H".action = focus-column-or-monitor-left;
        "${mod}+L".action = focus-column-or-monitor-right;

        # move things
        "${mod}+Shift+K".action = move-window-up-or-to-workspace-up;
        "${mod}+Shift+J".action = move-window-down-or-to-workspace-down;
        "${mod}+Shift+H".action = move-column-left-or-to-monitor-left;
        "${mod}+Shift+L".action = move-column-right-or-to-monitor-right;

        # stack and unstack
        "${mod}+Comma".action = consume-or-expel-window-left;
        "${mod}+Period".action = consume-or-expel-window-right;

        # screenshotting
        "${mod}+S".action = screenshot;
        "${mod}+Shift+S".action = screenshot-window;
        "${mod}+A".action = fish "wl-paste | satty -f - --fullscreen --copy-command 'wl-copy'";

        # resize things
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Shift+1".action = set-column-width "50%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";

        "XF86AudioRaiseVolume".action = fish "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
        "XF86AudioLowerVolume".action = fish "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
        "XF86AudioMute".action = fish "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute".action = fish "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86MonBrightnessUp".action = fish "brightnessctl s 5%+";
        "XF86MonBrightnessDown".action = fish "brightnessctl s 5%-";

        "XF86AudioPlay".action = fish "playerctl play-pause";
        "XF86AudioNext".action = fish "playerctl next";
        "XF86AudioPrev".action = fish "playerctl previous";

#        "Super+C".action = fish "fish ${../scripts/toggle-mute.fish}"; # this corrosponds to cortana buttons on alot of keyboards
      };
    };
  };
}
