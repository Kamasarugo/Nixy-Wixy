{ config, pkgs, inputs, ... }:

{
imports = [
  ./hyprland.nix
  ../stylix.nix
  ./niri.nix
  ./fish.nix
  
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

  #productive
  obsidian #Note taking app
  libreoffice-fresh #MSOffice replacement
  #browsers
  inputs.zen-browser.packages."${system}".default
  floorp-bin
  
  #utils
  brightnessctl #Brightness Control
  hyprshot
  ksnip #Screenshot
  btop #Task Manger/Hardware Monitor
  bluetui #Bluetooth
  upower #Power Management
  nemo #File Browser
  fuzzel #Dmenu
  dotool
  wf-recorder #Screen Recorder
  
  #tools
  nixd
  nix-output-monitor
  nh

  #fonts
  corefonts #Fonts

  #games
  steam
  heroic #Epic Games replacement thingy
  prismlauncher #Minecraft Mod Launcher
  lutris
  protonup-qt
  wine
  r2modman
  (
    vintagestory.overrideAttrs (old: rec {
    postInstall = ''
    cp -r ${../other/vintageStory}/* $out/share/vintagestory/
    '';
  })
  )
  
  #social
  vesktop #Discord Wrapper
  element-desktop #Matrix thingy

  #general
  spotify
  
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
