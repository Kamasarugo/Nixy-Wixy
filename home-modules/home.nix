{ config, pkgs, inputs, ... }:

{
imports = [
  ./hyprland.nix
  ../stylix.nix
  ./niri.nix
  ./fish.nix
  
  inputs.stylix.homeModules.stylix
  inputs.niri.homeModules.niri
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
  obsidian
  libreoffice-fresh
  floorp
  inputs.zen-browser.packages."${system}".default

  #utils
  brightnessctl
  hyprshot
  ksnip
  btop
  bluetui
  
  #tools
  nixd
  nix-output-monitor
  nh

  #fonts
  corefonts

  #games
  steam

  #unknown giblets
  vesktop
  
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
