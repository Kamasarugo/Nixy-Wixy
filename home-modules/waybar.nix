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
        "battery"
        "group/connections"
        "group/audio"
      ];

      modules-center = [
        
      ];

      modules-right = [
        "group/tray"
        "group/info"
      ];
# Primary Module Groups
  "group/connections" = {
    oritentation = "inherit";
    modules = [
      "group/network"
      "custom/bluetooth"
    ];
  };

  "group/info" = {
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

# Individial Modules

#Network

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

# Audio
pulsaudio = {
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
  on-scroll-up = "pactl set-sink-volume @DEAFULT_SINK@ +5%";
  on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
  smooth-scrolling-threshold = 1;
};

  "pulseaudio#mic" = {
    format = "{format_source}";
    format-source = "";
    format-source-muted = "";
    tooltip-format = "{volume}% {format_source} ";
    on-click = "pactl set-source-mute 0 toggle";
    on-scroll-down = "pactl set-source-volume 0 -1%";
    on-scroll-up = "pactl set-source-volume 0 +1%";
  };
  
  "pulseaudio/slider" = {
    min = 0;
    max = 140;
    orientation = "vertical";
  };
#CPU
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
}


