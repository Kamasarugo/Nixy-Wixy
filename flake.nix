{
  description = "description";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hytale-launcher = {
      url = "github:JPyke3/hytale-launcher-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    niri = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    openlogi = {
      url = "github:AprilNEA/OpenLogi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

 
  };
 outputs = { nixpkgs, niri, openlogi, catppuccin, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    nixosConfigurations = {
      nixos-laptop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          ./devices/laptop/hardware-configuration.nix
          ./configuration.nix
          ./home-modules/noctalia.nix
          catppuccin.nixosModules.catppuccin
           ];
      };

      nixos-desktop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          ./devices/pc/hardware-configuration.nix
          ./configuration.nix
          ./home-modules/noctalia.nix
          catppuccin.nixosModules.catppucci
          openlogi.nixosModules.default
            {
              environment.systemPackages = [
                openlogi.packages.x86_64-linux.default
              ];
              programs.openlogi = {
                  enable = true;
                  launchAtLogin = true;
              };
            }
        ];
      };
    };
  };
}

