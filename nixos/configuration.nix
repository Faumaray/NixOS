# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware), use something like:
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # It's strongly recommended you take a look at
    # https://github.com/nixos/nixos-hardware
    # and import modules relevant to your hardware.

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # You can also split up your configuration and import pieces of it here.
  ];

  # This will add your inputs as registries, making operations with them (such
  # as nix shell nixpkgs#name) consistent with your flake inputs.
  nix.registry = lib.mapAttrs' (n: v: lib.nameValuePair n { flake = v; }) inputs;

  # Will activate home-manager profiles for each user upon login
  # This is useful when using ephemeral installations
  environment.loginShellInit = ''
    [ -d "$HOME/.nix-profile" ] || /nix/var/nix/profiles/per-user/$USER/home-manager/activate &> /dev/null
  '';

  nix = {
    package = pkgs.nixFlakes;
    # Enable flakes and new 'nix' command
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    autoOptimiseStore = true;
  };

  # Remove if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;

  # FIXME: Add the rest of your current configuration

  # TODO: Set your hostname
  networking.hostName = "faumaray";
  networking.networkmanager.enable = true;
  # TODO: This is just an example, be sure to use whatever bootloader you prefer
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };


  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    faumaray = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      # initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" "networkmanager" "audio" "video" "storage" ];
    };
  };



  # Set your time zone.
  time.timeZone = "Europe/Samara";
  i18n.defaultLocale = "en_US.UTF-8";

  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ "Iosevka Nerd Font Mono" ];
      };

      enable = true;
    };

    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];
  };

  programs.xwayland.enable = true;
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true;
    # displayManager = {
    #   sddm = {
    #     enable = true;

    #   };
    # };

    videoDrivers = [ "nvidia" ];
    useGlamor = true;

  };

  # enable hardware features
  hardware = {
    nvidia = {
      prime = {
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
        offload.enable = true;
      };
      nvidiaPersistenced = true;
      modesetting.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };


  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    passwordAuthentication = false;
  };

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    audio.enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    gtkUsePortal = true;
  };

  sound.enable = true;


}
