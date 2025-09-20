{ config,  ... }:
let
  colors = config.lib.stylix.colors;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.main-bar = {
      layer = "top";
      position = "left";

      modules-left = [
        
      ];

      modules-center = [
        
      ];

      modules-right = [
        "group/info"
        "group/connections"
        "clock"
        "tray"
        "battery"
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
     # "custom/dmark"
      "group/gcpu"
      "memory"
      "disk"
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

#Info

  memory = {
    format = "<b>  \n{:2}󱉸</b>";
  };
  disk = {
    interval = 600;
    format = "<b> 󰋊 \n{percentage_used}󱉸</b>";
    path = "/";
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
    format = "{icon} {capacity}%";
    format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
    tooltip-format = "{time}, {cycles} cycles, {health}% health";
  };
  
  tray = {
    spacing = 5;
  };




       
    };
  };
}


