{
  description = "My NixOS config";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages

    nixpkgs-wayland = { # Nix wayland specific Packages
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = { # User Package Management
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix"; # Store ssh\gpg keys as AGE

    nur = {
      url = "github:nix-community/NUR"; # NUR Packages
    };

    nixgl = { # OpenGL
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = { # Defune Onlu One colorscheme for all your programs in Nix
      url = "github:misterio77/nix-colors";
    };

    # neoNixVim.url = "github:faumaray/Neovim/Nix";

    hyprland = { # Official Hyprland flake
      url = "github:hyprwm/Hyprland";
    };

    hyprpaper = { # Official Hyprland flake
      url = "github:hyprwm/hyprpaper";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";

    oxilay = { # My Overlay
      url = "github:Faumaray/OxiLay";
      inputs.nixpkgs.follows = "nixpkgs";
    };


  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      overlays = [
        inputs.nixpkgs-wayland.overlay
        inputs.nixgl.overlay
        inputs.hyprpaper.overlays.default
        inputs.rust-overlay.overlays.default
        inputs.oxilay.overlays.default
      ];
      host = {
        hostName = "faumaray";
        mainMonitor = "eDP-1";
        secondMonitor = "HDMI-A-1";
      };
      config = { allowUnfree = true; };
      pkgs = import nixpkgs { inherit overlays system config; };
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        faumaray = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs host overlays; };
          modules = [
            ./Hosts
            inputs.nur.nixosModules.nur
            inputs.hyprland.nixosModules.default
            inputs.agenix.nixosModule
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.faumaray = import ./Packages;
              home-manager.extraSpecialArgs = { inherit inputs host; };
            }
          ];
        };
      };
    };
}
