{ pkgs, inputs, lib, ... }:
{
  home-manager.users.kamasarugo = {
    home.stateVersion = "24.11";
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;

      settings = lib.mkForce ./noctalia.toml; # This may also be a string or path to a .toml file.
    };
  };
}
