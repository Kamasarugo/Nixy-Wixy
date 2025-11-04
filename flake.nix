{
  description = "description";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
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
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
   };

  };
 outputs = { nixpkgs, niri, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos-laptop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          ./devices/laptop/hardware-configuration.nix
          ./configuration.nix
          ];
          
      };

      nixos-desktop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          ./devices/pc/hardware-configuration.nix
          ./configuration.nix
        ];
      };
    };
  };
}

