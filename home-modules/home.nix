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
  quickshell
  nixd
  nix-output-monitor
  nh
  tailscale #vpn thingy
  ydotool #input recorder and macro thing
  wl-clipboard
  solaar #Logitech

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
  badlion-client #MC Mod Launcher
  (
    vintagestory.overrideAttrs (old: rec {
    postInstall = ''
    cp -r ${../other/vintageStory}/* $out/share/vintagestory/
    '';
  })
  )
  inputs.hytale-launcher.packages.${pkgs.system}.default
  #social
  vesktop #discord Wrapper
  element-desktop #matrix thingy
  #nheko #matrix thingy

  #general
  spotify #music

  cliphist
  gpu-screen-recorder
  xdg-desktop-portal-wlr
  cloudflare-warp
];
  home.file = {
  };

  programs.home-manager.enable = true;
}
