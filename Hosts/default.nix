{ inputs, host, overlays, lib, config, pkgs, ... }: {
  imports =
    [ ./hardware-configuration.nix ./services.nix ./fonts.nix ./misc.nix ];

  nixpkgs = {
    overlays = overlays;
    config = { allowUnfree = true; };
  };

  nix = {
    package = pkgs.nixFlakes;
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
      config.nix.registry;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://oxilay.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "oxilay.cachix.org-1:0IAF6/bNxEDtjLBe5dWsBGrH3aCDHhvFQhRLo1aEFdc="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  age.secrets.secret1.file = ../Secrets/ssh.age;

  system.stateVersion = "22.11";
}
