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
    
nixpkgs.config.allowUnfree = true;

programs = {
  wofi.enable = true;
  kitty.enable = true;
  helix.enable = true;
  firefox.enable = true;
  helix.settings.editor.indent-guides.render = true;
  btop.enable = true;
  fuzzel.enable = true;
  floorp.enable = true;
  # noctalia-shell.enable = true;
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
  yazi #tty file editor
  nemo #file editor
  # vscode #IDE

# tools
  satty #screenshot editor 
  # krita #image editor
  brightnessctl #brightness control
  btop #task manager/hardware monitor
  bluetui #bluetooth
  upower #power management
  noisetorch #noise suppresion
  tailscale #vpn
  solaar #logitech
  jellyfin-media-player #what it says
  obs-studio
  libqalculate #calculator library
  qalculate-qt #calculator
  waypipe #better ssh for DE
    
# utils
  fuzzel #dmenu
  bitwarden-desktop #password manager
  quickshell #use it like waybar
  nixd
  nix-output-monitor #better rebuild util
  nh #better rebuild
  ydotool #input recorder and macro
  wl-clipboard
  corefonts #font
  pipewire #audio
  ty #python type checker
  python3

# games
  steam #if you don't know...
  heroic #epic games replacement thingy
  prismlauncher #MC Mod Launcher
  lutris #game launcher thing
  protonup-qt #game compat.
  protonplus #game compat.
  wine #game compat.
  r2modman #mod Client
  xivlauncher #ffxiv
    (
    vintagestory.overrideAttrs (old: rec {
    postInstall = ''
    cp -r ${../other/vintageStory}/* $out/share/vintagestory/
    '';
  })
  )
  inputs.hytale-launcher.packages.${pkgs.system}.default
# honestly idk
  vesktop #discord wrapper
  element-desktop #matrix thingy
  spotify #music
 # nhecko #matrix thingy

];
  home.file = {
  };

  programs.home-manager.enable = true;
}
