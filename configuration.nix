{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./theme/stylix.nix
    
      inputs.home-manager.nixosModules.default
      inputs.stylix.nixosModules.stylix
      inputs.niri.nixosModules.niri
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  documentation.man.cache.enable = false;

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
    (final: prev: {
    noctalia = inputs.nixpkgs-old.legacyPackages.${prev.system}.noctalia;
    })
  ];

  # storage optimisation
  nix.optimise = {
    automatic = true;
    persistent = true;
    dates = [ "daily" ];
  };
  
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-vpnc
  ];
  networking.firewall.checkReversePath = false;
  networking.firewall.allowedUDPPorts = [ 51820 ];
  
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

  users.defaultUserShell = pkgs.fish;

  users.users.kamasarugo = {
    isNormalUser = true;
    description = "kamasarugo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOsAzvtGSiY2MQJQO5q8jV5IGRncpbHrtdwR0f23l+mL kamasarugo@nixos"
    ];
  };

    environment.sessionVariables = {
      # LD_LIBRARY_PATH = [ "${pkgs.libXcursor}/lib" "${pkgs.libXi}/lib"];
      LD_LIBRARY_PATH = lib.makeLibraryPath [
        pkgs.libXcursor
        pkgs.libXi
      ];
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

nixpkgs.config = {
  allowUnfree = true;
  permittedInsecurePackages = [
    "electron-39.8.10"
    "electron-40.10.5"
  ];
};
  
 environment.systemPackages = with pkgs; [
  helix
  material-symbols
  xwayland-satellite
  xwayland
  libXcursor
  libXi
  inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
];
 programs = {

   hyprland.enable = true;
   
   niri.enable  = true;
   niri.package = pkgs.niri-unstable;

   fish.enable = true;

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
    
    xserver = {
      enable = true;
      xkb = {
        layout = "au";
        variant = "";
        };
      };
  

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = false;
        autoNumlock = true;
      };
      
    };
    
    logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "ignore";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    thermald.enable = true;

    flatpak.enable = true;
    openssh = {
      enable = true;
      settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false; # Disables keyboard-interactive/pam password prompts
      PermitRootLogin = "prohibit-password"; # Recommended instead of "yes"
      };
    };
    upower.enable = true;
  };

  security.rtkit.enable = true;

  system.stateVersion = "24.11";
  
}
