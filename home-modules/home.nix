{ config, pkgs, inputs, ... }:

{
imports = [
  ./hyprland.nix
  ../theme/stylix.nix
  ./niri.nix
  ./fish.nix

#  inputs.caelestia-shell.homeModules.default
  inputs.stylix.homeModules.stylix
];

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.monospace = [
    config.stylix.fonts.monospace.name
    "DejaVu Sans"
  ];
    
nixpkgs.config.allowUnfree = true;

programs.wofi.enable = true;
programs.kitty.enable = true;
programs.helix.enable = true;
programs.firefox.enable = true;
programs.helix.settings.editor.indent-guides.render = true;
programs.btop.enable = true;
programs.fuzzel.enable = true;
programs.floorp.enable = true;
#programs.quickshell.enable = true;

  programs.git = {
    enable = true;
    userName = "kamasarugo";
    userEmail = "143808628+Kamasarugo@users.noreply.github.com";
    extraConfig.init.defaultBranch = "main";
    delta.enable = true; 
  };

  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [

  inputs.caelestia-shell.packages.${pkgs.system}.with-cli

  #editors
  obsidian #note taking app
  libreoffice-fresh #MSOffice replacement
  satty #screenshot editor
  krita #image editor

  #browsers
  floorp-bin #firefox wrapper
  vivaldi # chromium
  
  #utils
  brightnessctl #brightness control
  btop #task manager/hardware monitor
  bluetui #bluetooth
  upower #power management
  nemo #file browser
  fuzzel #dmenu
  wf-recorder #screen recorder
  noisetorch #noise suppresion
  hyprpaper #wallpaper
  bitwarden-desktop #password manager
  dunst
  quickshell

  #tools
  nixd
  nix-output-monitor
  nh
  tailscale #vpn thingy
  ydotool #input recorder and macro thing
  wl-clipboard

  #fonts
  corefonts

  #Games
  steam #If you don't know...
  heroic #Epic Games replacement thingy
  prismlauncher #MC Mod Launcher
  lutris #Game launcher thing
  protonup-qt #Game compat.
  wine #Game compat.
  r2modman #Mod Client
  modrinth-app #MC Mod launcher
  (
    vintagestory.overrideAttrs (old: rec {
    postInstall = ''
    cp -r ${../other/vintageStory}/* $out/share/vintagestory/
    '';
  })
  )
  
  #social
  vesktop #discord Wrapper
  element-desktop #matrix thingy

  #general
  spotify #music


  #sort later
  ddcutil
  app2unit
  #libcava
  lm_sensors
  aubio
  glibc
  gcc
  swappy
  bash
  cmake
  ninja
  pipewire
  
];
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kamasarugo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
