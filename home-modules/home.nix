{ config, pkgs, inputs, ... }:

{
imports = [
  ./hyprland.nix
  ../theme/stylix.nix
  ./niri.nix
  ./fish.nix
  
  inputs.stylix.homeModules.stylix
];

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.monospace = [
    config.stylix.fonts.monospace.name
    "DejaVu Sans"
  ];
    
nixpkgs.config = {
  allowUnfree = true;
  permittedInsecurePackages = [
    "electron-39.8.10"
    "electron-40.10.5"
    ];
  };

programs = {
  wofi.enable = true;
  kitty.enable = true;
  helix.enable = true;
  firefox.enable = true;
  helix.settings.editor.indent-guides.render = true;
  btop.enable = true;
  fuzzel.enable = true;
  floorp.enable = true;
  quickshell.enable = true;
  delta.enableGitIntegration = true;
  delta.enable = true;
  yazi.enable = true;

  git = {
    enable = true;
    settings = {
      user.name = "kamasarugo";
      user.email = "143808628+Kamasarugo@users.noreply.github.com";
      init.defaultBranch = "main";
    };
  };
  
};
  home.stateVersion = "24.11";

  home.packages = with pkgs; [

# productivity
  obsidian #note taking app
  libreoffice-fresh #office replacement
  floorp-bin #firefox wrapper
  vivaldi #chromium
  nemo #file editor
  # vscode #IDE

# tools
  satty #screenshot editor 
  # krita #image editor
  brightnessctl #brightness control
  bluetui #bluetooth
  upower #power management
  solaar #logitech
  jellyfin-media-player #what it says
  libqalculate #calculator library
  qalculate-qt #calculator
  waypipe #better ssh for DE
    
# utils
  bitwarden-desktop #password manager
  nixd
  nix-output-monitor #better rebuild util
  ydotool #input recorder and macro
  wl-clipboard
  corefonts #font
  ty #python type checker
  ruff

# games
  heroic #epic games replacement thingy
  prismlauncher #MC Mod Launcher
  # lutris #game launcher thing
  protonup-qt #game compat.
  protonplus #game compat.
  wine #game compat.
  r2modman #mod Client
#    (
#    vintagestory.overrideAttrs (old: rec {
#    postInstall = ''
#    cp -r ${../other/vintageStory}/* $out/share/vintagestory/
#    '';
#  })
#  )
  # inputs.hytale-launcher.packages.${pkgs.system}.default
# honestly idk
  vesktop #discord wrapper
  element-desktop #matrix thingy
  spotify #music
  # nheko #matrix thingy
  #
  # UNI
  logisim-evolution

];
  home.file = {
  };

  programs.home-manager.enable = true;
}
