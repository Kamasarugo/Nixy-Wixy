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
      position = "right";

      modules-left = [
        "clock"
        "custom/notification"
        "battery"
        "group/connections"
        "group/audio"
      ];

      modules-center = [
        
      ];

      modules-right = [
        "group/tray"
        "group/system-info"
      ];
# Primary Module Groups
  "group/connections" = {
    oritentation = "inherit";
    modules = [
      "group/network"
      "group/bluetooth"
    ];
  };

  "group/system-info" = {
    orientation = "inherit";
    drawer = {
      transition-duration = 500;
      transition-left-to-right = false;
    };
    modules = [
      "custom/info-icon"
      "group/gcpu"
      "memory"
      "disk"
    ];
  };

  "group/tray" = {
    orientation = "inherit";
    drawer = {
      transition-duration = 500;
      transition-left-to-right = false;
    };
    modules = [
      "custom/drawer-icon"
      "tray"
    ];
  };

  "group/audio" = {
    orientation = "inherit";
    drawer = {
      transition-duration = 500;
      trainsition-to-right = true;
    };
    modules = [
      "pulseaudio"
      "pulseaudio#mic"
      "pulseaudio/slider"
    ];
  };
# Secondary Module Groups

  "group/gcpu" = {
    orientation = "inherit";
    modules = [
      "custom/cpu-icon"
      "custom/cputemp"
      "cpu"
    ];
  };
  
  "group/network" = {
    orientation = "inherit";
    drawer = {
      transition-duration = 500;
      transition-left-to-right = true;
    };
    modules = [
      "network"
      "network/speed"
    ];
  };

  "group/bluetooth" = {
    orientation = "inherit";
    drawer = {
      transition-duration = 500;
      transition-left-to-right = true;
    };
    
    modules = [
      "bluetooth"
      "bluetooth#status"
    ];
  };

# Individial Modules

# Network

  network = {
    format = "{icon}";
    format-icons = {
      wifi = [
        "󰤨"
      ];
      ethernet = [
        "󰈀"
      ];
      disconnected = [
        "󰖪"
      ];
    };
    format-wifi = "󰤨";
    format-ethernet = "󰈀";
    format-disconnected = "󰖪";
    format-linked = "󰈁";
    tooltip = false;
  };
  "network/speed" = {
    format = " {bandwidthDownBits} ";
    rotate = 90;
    interval = 5;
    tooltip-format = "{ipaddr}";
    tooltip-format-wifi = "{essid} ({signalStrength}%)   \n{ipaddr} | {frequency} MHz{icon} ";
    tooltip-format-ethernet = "{ifname} 󰈀 \n{ipaddr} | {frequency} MHz{icon} ";
    tooltip-format-disconnected = "Not Connected to any type of Network";
    tooltip = true;
  };

# Bluetooth

bluetooth = {
    format-on = "";
    format-off = "󰂲";
    format-disabled = "";
    format-connected = "<b></b>";
    tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
    tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
    tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
    tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
    on-click = "bluetui";
  };

  "bluetooth#status" = {
    format-on = "";
    format-off = "";
    format-disabled = "";
    format-connected = "<b>{num_connections}</b>";
    format-connected-battery = "<small><b>{device_battery_percentage}%</b></small>";
    tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
    tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
    tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
    tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
    on-click = "bluetui";
  };

# Audio
pulseaudio = {
  format = "{icon}";
  tooltip-format = "{volume}% {icon} | {desc}";
  format-muted = "󰖁";
  format-icons = {
    default = [
      "󰕿"
      "󰖀"
      "󰕾"    
    ];
  };
  on-click = "volume mute";
  on-click-middle = "pavucontrol";
  on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
  on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
  smooth-scrolling-threshold = 1;
};

  "pulseaudio#mic" = {
    format = "{format_source}";
    format-source = "";
    format-source-muted = "";
    tooltip-format = "{volume}% {format_source} ";
    on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
    on-scroll-down = "pactl set-source-volume @DEFAULT_SOURCE@ -1%";
    on-scroll-up = "pactl set-source-volume @DEFAULT_SOURCE@ +1%";
  };
  
  "pulseaudio/slider" = {
    min = 0;
    max = 140;
    orientation = "vertical";
  };

# CPU
  "custom/cpu-icon" = {
    format = "󰻠";
    tooltip = false;
  };
  
  "custom/cputemp" = {
    format = "{}";
    interval = 10;
    return-type = "json";
  };
    
  cpu = {
    format = "<b>{usage}󱉸</b>";
    on-click = "foot btop";
  };
# Notifications

  "custom/notification" = {
    tooltip = false;
    format = "{icon}";
    format-icons = {
      notification = "<span foreground='red'><sup></sup></span>";
      none = "";
      dnd-notification = "<span foreground='red'><sup></sup></span>";
      dnd-none = "";
      inhibited-notification = "<span foreground='red'><sup></sup></span>";
      inhibited-none = "";
      dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
      dnd-inhibited-none = "";
    };
    
    return-type = "json";
    exec-if = "which swaync-client";
    exec = "swaync-client -swb";
    on-click = "swaync-client -t -sw";
    on-click-right = "swaync-client -d -sw";
    escape = true;
  };
    
  memory = {
    format = "<b>  \n{:2}󱉸</b>";
    tooltip = false;
  };
  
  disk = {
    interval = 600;
    format = "<b> 󰋊 \n{percentage_used}󱉸</b>";
    path = "/";
    tooltip = false;
    };
      
  clock = {
    format = "{:%H\n%M}";
    tooltip-format = "<tt><small>{calendar}</small></tt>";
    calendar = {
      mode = "month";
      mode-mon-col = 3;
      weeks-pos = "right";
      on-scroll = 1;
      on-click-right = "mode";
      format = {
        today = "<span color='#a6e3a1'><b><u>{}</u></b></span>";
      };
    };
  };

  battery = {
    rotate = 270;
    states = {
      good = 95;
      warning = 30;
      critical = 15;
    };
    format = "{icon}";
    format-charging = "<b>{icon} </b>";
    format-full = "<span color='#82A55F'><b>{icon}</b></span>";
    format-icons = [
      "󰁻"
      "󰁼"
      "󰁾"
      "󰂀"
      "󰂂"
      "󰁹"
    ];
    tooltip-format = "{timeTo} {capacity} % | {power} W";
  };
     
  tray = {
    spacing = 5;
  };





  
# Icons

  "custom/drawer-up" = {
    format = "^";
    tooltip = false;
  };

  "custom/drawer-icon" = {
    format = "≡";
    tooltip = false;
  };

  "custom/info-icon" = {
      format = "ⓘ";
      tooltip = false;
    };



       
    };
  };
# styling
  programs.waybar.style = ''
@import "/home/kamasarugo/Nixy-Wixy/home-modules/colors.css";
@define-color active @color4;

* {
  font-size: 16px;
  font-family: "JetBrainsMono Nerd Font,JetBrainsMono NF";
  min-width: 8px;
  min-height: 0px;
  border: none;
  border-radius: 0;
  box-shadow: none;
  text-shadow: none;
  padding: 0px;

}

window#waybar {
  transition-property: background-color;
  transition-duration: 0.5s;
  border-radius: 8px;
  border: 2px solid @active;
  background: @background;
  background: alpha(@background, 0.7);
  color: lighter(@active);
}

menu,
tooltip {
  border-radius: 8px;
  padding: 2px;
  border: 1px solid lighter(@active);
  background: alpha(@background, 0.6);

  color: lighter(@active);
}

menu label,
tooltip label {
  font-size: 14px;
  color: lighter(@active);
}

#tray>.needs-attention {
  animation-name: blink-active;
  animation-duration: 1s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

.modules-right {
  margin: 0px 6px 6px 6px;
  border-radius: 4px;
  background: alpha(@background, 0.4);
  color: lighter(@active);
}

.modules-left {
  transition-property: background-color;
  transition-duration: 0.5s;
  margin: 6px 6px 6px 6px;
  border-radius: 4px;
  background: alpha(@background, 0.4);
  color: lighter(@active);
}

#custom-notification,
#system-info,
#clock,
#battery,
#gcpu,
#memory,
#disk,
#together,
#audio,
#connections,
#brightness,
#power,
#custom-updates,
#tray {
  border-radius: 4px;
  margin: 2px 2px 4px 2px;
  background: alpha(darker(@active), 0.3);
}

#gcpu {
  padding: 8px 0px 8px 0px;
}

#custom-cpu-icon {
  font-size: 25px;
}

#custom-cputemp,
#disk,
#memory,
#cpu {
  font-size: 14px;
  font-weight: bold;
}

#network.wifi {
  padding-right: 4px;
}

#system-info,
#custom-weather,
#tray {
  padding: 4px 0px 4px 0px;
}

#bluetooth {
  padding-top: 2px;
}

#battery {
  border-radius: 8px;
  padding: 4px 0px;
  margin: 4px 2px 4px 2px;
}

#battery.discharging.warning {
  animation-name: blink-yellow;
  animation-duration: 1s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

#battery.discharging.critical {
  animation-name: blink-red;
  animation-duration: 1s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

#clock {
  font-weight: bold;
  padding: 4px 2px 2px 2px;
}

#pulseaudio.mic {
  border-radius: 4px;
  color: @background;
  background: alpha(darker(@foreground), 0.6);
  padding-left: 4px;
}

#backlight-slider slider,
#pulseaudio-slider slider {
  background-color: transparent;
  box-shadow: none;
}

#backlight-slider trough,
#pulseaudio-slider trough {
  margin-top: 4px;
  min-width: 6px;
  min-height: 60px;
  border-radius: 8px;
  background-color: alpha(@background, 0.6);
}

#backlight-slider highlight,
#pulseaudio-slider highlight {
  border-radius: 8px;
  background-color: lighter(@active);
}

#bluetooth.discoverable,
#bluetooth.discovering,
#bluetooth.pairable {
  border-radius: 8px;
  animation-name: blink-active;
  animation-duration: 1s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

@keyframes blink-active {
  to {
    background-color: @active;
    color: @foreground;
  }
}

@keyframes blink-red {
  to {
    background-color: #c64d4f;
    color: @foreground;
  }
}

@keyframes blink-yellow {
  to {
    background-color: #cf9022;
    color: @foreground;
  }
}
'';
}

