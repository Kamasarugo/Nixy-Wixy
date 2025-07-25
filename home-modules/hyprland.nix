# This is an example Hyprland config file.
# Refer to the wiki for more information.
# https://wiki.hyprland.ord/Configuring/

# Please note not all available setting / options are set here.
# For a full list, see the wiki

# You can split this configuration into multiple files
# Create your files separately and then link them to this file like this:
# source = ~/.config/hypr/myColors.conf

{ config, osConfig, lib , ... }:


###############
## VARIABLES ##
###############

let
  mod = "SUPER";
  menu = "wofi --show drun";
  terminal = "kitty";
  
in {
 
  # IMPORTS #
  imports = [
    ./waybar.nix
];
  
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {


################
### MONITORS ###
################

    # See https://wiki.hyprland.org/Configuring/Monitors/
    monitor = [
    ", preffered, auto, 1" # Default for unspecified monitors
    # "Extra monitors" --> "HDMI-A-1, 1920x1080@60, auto, 1" 
      ];
    
#####################
### LOOK AND FEEL ###
#####################

    # Refer to https://wiki.hyprland.org/Configuring/Variables/

    # https://wiki.hyprland.org/Configuring/Variables/#general
    general =  {
        gaps_in = 3;
        gaps_out = 10;

        border_size = 2;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        #"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        #"col.inactive_border" = "rgba(595959aa)";
        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
    };
      
      # https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 0.9;

        shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            #color = "rgba(1a1a1aee)";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
            enabled = true;
            size = 3;
            passes = 1;

            vibrancy = 0.1696;
        };
    };

        exec-once = [
          "systemctl --user enable --now waybar.service"
         ]; 

        
#    # https://wiki.hyprland.org/Configuring/Variables/#animations
#    animations = {
#       enabled = yes, please :)
#
#        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
#
#        bezier = easeOutQuint,0.23,1,0.32,1
#        bezier = easeInOutCubic,0.65,0.05,0.36,1; 
#        bezier = linear,0,0,1,1
#        bezier = almostLinear,0.5,0.5,0.75,1.0
#        bezier = quick,0.15,0,0.1,1
#
#        animation = global, 1, 10, default
#        animation = border, 1, 5.39, easeOutQuint
#        animation = windows, 1, 4.79, easeOutQuint
#        animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
#        animation = windowsOut, 1, 1.49, linear, popin 87%
#        animation = fadeIn, 1, 1.73, almostLinear
#        animation = fadeOut, 1, 1.46, almostLinear
#        animation = fade, 1, 3.03, quick
#        animation = layers, 1, 3.81, easeOutQuint
#        animation = layersIn, 1, 4, easeOutQuint, fade
#        animation = layersOut, 1, 1.5, linear, fade
#        animation = fadeLayersIn, 1, 1.79, almostLinear
#        animation = fadeLayersOut, 1, 1.39, almostLinear
#        animation = workspaces, 1, 1.94, almostLinear, fade
#        animation = workspacesIn, 1, 1.21, almostLinear, fade
#        animation = workspacesOut, 1, 1.94, almostLinear, fade
#    }; 
# Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
# "Smart gaps" / "No gaps when only"
# uncomment all if you wish to use that.
# workspace = w[tv1], gapsout:0, gapsin:0
# workspace = f[1], gapsout:0, gapsin:0
# windowrulev2 = bordersize 0, floating:0, onworkspace:w[tv1]
# windowrulev2 = rounding 0, floating:0, onworkspace:w[tv1]
# windowrulev2 = bordersize 0, floating:0, onworkspace:f[1]
# windowrulev2 = rounding 0, floating:0, onworkspace:f[1]


    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
    };

    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    master = {
        new_status = "master";
        };

    # https://wiki.hyprland.org/Configuring/Variables/#misc
    misc = {
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = lib.mkDefault false; # If true disables the random hyprland logo / anime girl background. :(
    };


###################
### KEYBINDINGS ###
###################

    # See https://wiki.hyprland.org/Configuring/Keywords/
  bind = [
      "${mod}, Q, killactive"
      "${mod}, RETURN, exec, ${terminal}"
      "${mod}, D, exec, ${menu}"
      "${mod}, F, fullscreen"
      "${mod}, W, togglegroup"
      "${mod}, E, exit"
    
      "${mod}, S, exec, hyprshot -. region -- ksnip" 
      "${mod} SHIFT, S, exec, hyprshot -m window -- ksnip"
      "${mod} CONTROL, S, exec, hyprshot -m output -- ksnip"

      "${mod}, H, movefocus, l"
      "${mod}, L, movefocus, r"
      "${mod}, J, movefocus, d"
      "${mod}, K, movefocus, u"
      "${mod} SHIFT, H, movewindow, l"
      "${mod} SHIFT, L, movewindow, r"
      "${mod} SHIFT, J, movewindow, d"
      "${mod} SHIFT, K, movewindow, u"

      "${mod}, 1, workspace, 1"
      "${mod}, 2, workspace, 2"
      "${mod}, 3, workspace, 3"
      "${mod}, 4, workspace, 4"
      "${mod}, 5, workspace, 5"
      "${mod}, 6, workspace, 6"
      "${mod}, 7, workspace, 7"
      "${mod}, 8, workspace, 8"
      "${mod}, 9, workspace, 9"
      "${mod}, 0, workspace, 10"
      "${mod} SHIFT, 1, movetoworkspace, 1"
      "${mod} SHIFT, 2, movetoworkspace, 2"
      "${mod} SHIFT, 3, movetoworkspace, 3"
      "${mod} SHIFT, 4, movetoworkspace, 4"
      "${mod} SHIFT, 5, movetoworkspace, 5"
      "${mod} SHIFT, 6, movetoworkspace, 6"
      "${mod} SHIFT, 7, movetoworkspace, 7"
      "${mod} SHIFT, 8, movetoworkspace, 8"
      "${mod} SHIFT, 9, movetoworkspace, 9"
      "${mod} SHIFT, 0, movetoworkspace, 10"  
      ];
  

    bindel = [
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ",XF86MonBrightnessUp, exec, brightnessctl set +5%"      
    ];

    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
      ];
    };
}
