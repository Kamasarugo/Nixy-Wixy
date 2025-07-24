{ config, lib, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.main-bar = {
      layer = "top";
      
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-center = [
        "clock"
      ];
      
      modules-right = [
        "temperature"
        "cpu"
        "memory"
        "backlight"
        "pulseaudio"
        "network"
        "battery"
        "cal"
        "tray"
      ];

      "hyprland/window".icon = true;

      tray = {
        spacing = 5;
      };
  

    clock = {
        format = "{:%H:%M}  ";
        format-alt = "{:%A, %B %d, %Y (%R)}  ";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
                    mode          = "year";
                    mode-mon-col  = 3;
                    weeks-pos     = "right";
                    on-scroll     = 1;
                    format = {
                              "months" =     "<span color='#ffead3'><b>{}</b></span>";
                              "days" =       "<span color='#ecc6d9'><b>{}</b></span>";
                              "weeks" =      "<span color='#99ffdd'><b>W{}</b></span>";
                              "weekdays" =   "<span color='#ffcc66'><b>{}</b></span>";
                              "today" =      "<span color='#ff6699'><b><u>{}</u></b></span>";
                              };
                    };
            };
#        actions =  {
#                    on-click-right = "mode";
#                    on-scroll-up = "tz_up";
#                    on-scroll-down = "tz_down";
#                    on-scroll-up = "shift_up";
#                    on-scroll-down = "shift_down";
#                    };

      battery = {
        format = "{icon} {capacity}%";
        format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        tooltip-format = "{time}, {cycles} cycles, {health}% health";
      };

      network = {
        format = "{icon} {essid}";
        format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = " muted";
        format-icons.default = [ "" ""];
        on-click = "pavucontrol";
        scroll-step = 1;
      };

      backlight = {
        format = " {percent}%";
      };

      cpu = {
        interval = 1;
        format = " {usage}%";
      };

      memory = {
        interval = 1;
        format = " {percentage}%";
        tooltip-format = "{used} GiB / {total} GiB";
      };

      temperature = {
        interval = 1;
        thermal-zone = 2;
        critical-threshold = 80;
        format = " {temperatureC}°C";
      };
    };

    style = builtins.readFile ./waybar.css;
  };
}
