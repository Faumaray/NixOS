# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }:
let
  rust = pkgs.rust-bin.selectLatestNightlyWith
    (toolchain: toolchain.complete.override {
      extensions = [ "rust-src" "rust-analysis" "rust-analyzer-preview" "cargo" "rustfmt" "clippy" "miri" "llvm-tools-preview" ];
      targets = [ "x86_64-pc-windows-gnu" "x86_64-unknown-linux-gnu" ];
    });
  dbus-hypr-environment = pkgs.writeTextFile {
    name = "dbus-hypr-environment";
    destination = "/bin/dbus-hypr-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY
      systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schema/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
      '';
  };

in
{
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors), use something like:
    ./dunst.nix
    ./waybar.nix
    ./hyprland.nix
    ./alacritty.nix
    # Feel free to split up your configuration and import pieces of it here.
  ];
  home.file = {
    ".cargo" = {
      source = "../misc/.cargo";
      recursive = true;
    };
    ".conan" = {
      source = "../misc/.conan";
      recursive = true;
    };
  };
  # Comment out if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;
  home.packages = (import ./packages.nix) {
    inherit pkgs;
    extras = with pkgs; [
      wofi
      ripgrep
      zoxide
      dbus-hypr-environment
      configure-gtk
      neovim-qt
      rust
    ];
  };
  home.sessionVariables = {
    DRI_PRIME = 1;
    GDK_BACKEND = wayland;
    LIBVA_DRIVER_NAME = nvidia;
    SDL_VIDEODRIVER = wayland;
    WINIT_UNIX_BACKEND = wayland;
    SAL_USE_VCLPLUGIN = gtk3;
    ECORE_EVAS_ENGINE = wayland_shm;
    ELM_ENGINE = wayland_shm;
    _JAVA_AWT_WM_NONREPARENTING = 1;
    RTC_USE_PIPEWIRE = true;
    XDG_SESSION_TYPE = wayland;
    XDG_SESSION_DESKTOP = hyprland;
    XDG_CURRENT_DESKTOP = hyprland;
    #GTK_THEME=Catppuccin-purple:dark
    #XCURSOR_THEME=CatppuccinMochaLavender
    #XKB_DEFAULT_LAYOUT=us
    QT_QPA_PLATFORM = wayland;
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_WAYLAND_FORCE_DPI = physical;
    CLUTTER_BACKEND = wayland;
    #WLR_DRM_DEVICES=/dev/dri/card0:/dev/dri/card1;#Check if exists
    WLR_NO_HARDWARE_CURSORS = 1;
    __NV_PRIME_RENDER_OFFLOAD = 1;
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = NVIDIA-G0;
    __VK_LAYER_NV_optimus = NVIDIA_only;
    GBM_BACKEND = nvidia-drm;
    WLR_DRM_NO_ATOMIX = 0;
    __GL_GSYNC_ALLOWED = 1;
    __GL_VRR_ALLOWED = 1;
    __GLX_VENDOR_LIBRARY_NAME = nvidia;
    #__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json:/usr/share/glvnd/egl_vendor.d/10_nvidia.json
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
  };
  # Add stuff for your user as you see fit:

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Faumaray";
    userEmail = "faumaray@gmail.com";
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      github.user = "faumaray";
      init.defaultBranch = "main";
      push.default = "tracking";
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "colorize" "rust" "python" " extract" "zoxide" "zsh-interactive-cd" ];
      # theme = "spaceship";
      theme = "robbyrussell";
    };

    shellAliases = {
      cat = "bat --paging=never";
      rebase = "git fetch --all --prune --prune-tags && git rebase";
      nixos_switch = "sudo nixos-rebuild switch --flake ~/.dotfiles/flake.nix";
      nixos_test = "sudo nixos-rebuild test --flake ~/.dotfiles/flake.nix";
    };

    plugins = [
      {
        name = "zsh-z";
        src = pkgs.fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "b5e61d03a42a84e9690de12915a006b6745c2a5f";
          sha256 = "1gsgmsvl1sl9m3yfapx6bp0y15py8610kywh56bgsjf9wxkrc3nl";
        };
      }
    ];
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
