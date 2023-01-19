{ inputs, lib, config, pkgs, host, ... }: {
  home = {
    username = "faumaray";
    homeDirectory = "/home/faumaray";
    pointerCursor = {                         # This will set cursor system-wide so applications can not choose their own
      name = "Catppuccin-Mocha-Dark-Cursors";
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 14;
    };
  };

  gtk = {                                     # Theming
    enable = true;
    theme = {
      name = "Catppuccin-Dark";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrains Mono Medium";         # or FiraCode Nerd Font Mono Medium
    };                                        # Cursor is declared under home.pointerCursor
  };
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME= "qt5ct";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    WLR_NO_HARDWARE_CURSORS = 1;
    XCURSOR_SIZE = 14;
    # Steam needs this to find Proton-GE
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
    # note: this doesn't replace PATH, it just adds this to it
    PATH = "\${PATH}:\${XDG_BIN_HOME}";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    autocd = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "colorize" "rust" " extract" "zsh-interactive-cd" ];
      # theme = "spaceship";
      theme = "robbyrussell";
    };
    initExtra = ''
      eval "$(direnv hook zsh)"
    '';

    shellAliases = {
      rebase = "git fetch --all --prune --prune-tags && git rebase";
      gamescope = "INTEL_DEBUG=norbc nixGL gamescope -w 1920 -h 1080 -W 1920 -H 1080 -R --prefer-vk-device=8086:5917 -- prime-run";
      nixos-switch =
        "sudo nixos-rebuild switch #.faumaray --flake ~/NixOsConfig";
      nixos_test = "sudo nixos-rebuild test #.faumaray --flake ~/NixOsConfig";
    };
    

  };

  # Add stuff for your user as you see fit:

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Aleksey Selihov";
    userEmail = "faumaray@gmail.com";
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      github.user = "faumaray";
      init.defaultBranch = "main";
      push.default = "tracking";
    };
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  programs.foot = {
    enable = true;
  };

  services.lorri = {
    enable = true;
    enableNotifications = true;
  };

  services.udiskie = {
    enable = true;
    notify = true;
  };

  services.gnome-keyring.enable = true;

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
