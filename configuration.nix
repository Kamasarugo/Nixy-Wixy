{ config, pkgs, inputs, ... }:

{
  imports = [
    ./theme/stylix.nix
    
      inputs.home-manager.nixosModules.default
      inputs.stylix.nixosModules.stylix
      inputs.niri.nixosModules.niri
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  documentation.man.generateCaches = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    logitech.wireless.enable = true;
  };
 
   nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  # storage optimisation
  nix.optimise = {
    automatic = true;
    persistent = true;
    dates = [ "daily" ];
  };
  
  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Keymap
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  users.users.kamasarugo = {
    isNormalUser = true;
    description = "kamasarugo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

    environment.sessionVariables = {
    # flatpak dirs
    XDG_DATA_DIRS = [
      "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
    ];
  };

stylix.homeManagerIntegration.autoImport = false;

home-manager = {
  backupFileExtension = "hm-backup";
  extraSpecialArgs = { inherit inputs; };
  users = {
    "kamasarugo" = import ./home-modules/home.nix;
  };
};

nixpkgs.config.allowUnfree = true;
  
 environment.systemPackages = with pkgs; [
  helix
  material-symbols
  #inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
];
 programs = {
   hyprland.enable = true;
   
   niri.enable  = true;
   niri.package = pkgs.niri-unstable;

   steam.enable = true;

   noisetorch.enable = true;

   nh = {
     enable = true;
     # flake = "/home/kamasarugo/Nixy-Wixy";
     clean = {
       enable = true;
       dates  = "daily";
       extraArgs = "--keep 5 --no-gcroots --optimise";
     };
   };
   
 };

  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
      };
      
    };
    
    logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "ignore";
    };

    thermald.enable = true;

    flatpak.enable = true;
    openssh.enable = true;
  };

  system.stateVersion = "24.11";
  
}
