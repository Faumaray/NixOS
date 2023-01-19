# inputs.nixvim.homeManagerModules.nixvim

{ inputs, lib, config, pkgs, host, ... }: {
  imports = [
    inputs.nix-colors.homeManagerModule
    inputs.hyprland.homeManagerModules.default
    ./waybar.nix
    ./hyprland.nix
    ./dunst.nix
    ./rofi.nix
    ./misc.nix
    ./rust.nix
    ./packages.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.kanagawa;
}
