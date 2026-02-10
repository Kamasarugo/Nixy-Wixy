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

  obsidian #note taking app
  libreoffice-fresh #MSOffice replacement
  satty #screenshot editor
  krita #image editor
  floorp-bin #firefox wrapper
  vivaldi # chromium
  brightnessctl #brightness control
  btop #task manager/hardware monitor
  bluetui #bluetooth
  upower #power management
  yazi #tty file browser
  nemo #file browser
  fuzzel #dmenu
  noisetorch #noise suppresion
  hyprpaper #wallpaper
  bitwarden-desktop #password manager
  quickshell
  nixd
  nix-output-monitor
  nh
  tailscale #vpn
  ydotool #input recorder and macro
  wl-clipboard
  solaar #Logitech
  corefonts
  steam #If you don't know...
  heroic #Epic Games replacement thingy
  prismlauncher #MC Mod Launcher
  lutris #Game launcher thing
  protonup-qt #Game compat.
  protonplus #Game compat.
  wine #Game compat.
  r2modman #Mod Client
    (
    vintagestory.overrideAttrs (old: rec {
    postInstall = ''
    cp -r ${../other/vintageStory}/* $out/share/vintagestory/
    '';
  })
  )
  inputs.hytale-launcher.packages.${pkgs.system}.default
  vesktop #discord Wrapper
  element-desktop #matrix thingy
 # nhecko #matrix thingy
  spotify #music
  cliphist
  gpu-screen-recorder
  xdg-desktop-portal-wlr
  pipewire
  cloudflare-warp
  jellyfin-media-player

  obs-studio
];
  home.file = {
  };

  programs.home-manager.enable = true;
}
