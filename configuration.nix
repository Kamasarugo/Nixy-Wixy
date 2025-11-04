# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./theme/stylix.nix
    
      inputs.home-manager.nixosModules.default
      inputs.stylix.nixosModules.stylix
      inputs.niri.nixosModules.niri
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

   nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  # storage optimisation
  nix.optimise = {
    automatic = true;
    persistent = true;
    dates = [ "daily" ];
  };

  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };
  
  services.thermald.enable = true;

  services.flatpak.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
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

# This is to make sure stylix is loaded last
# Remember to add stylic to new users
stylix.homeManagerIntegration.autoImport = false;

home-manager = {
  backupFileExtension = "hm-backup";
  extraSpecialArgs = { inherit inputs; };
  users = {
    "kamasarugo" = import ./home-modules/home.nix;
  };
};
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
 # BASE CONFIG!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 environment.systemPackages = with pkgs; [
  helix
  material-symbols
];
  programs.hyprland.enable = true; #enable hyprland

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  programs.steam.enable = true;
  
  services.displayManager.ly.enable = true;

  services.logind.settings.Login = {
  HandlePowerKey = "ignore";
  HandlePowerKeyLongPress = "ignore";
};

programs.noisetorch.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
