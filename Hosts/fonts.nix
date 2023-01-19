{ inputs, host, overlays, lib, config, pkgs, ... }: {

  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true; # ls /run/current-system/sw/share/X11/fonts/
    fontconfig = {
      enable = true;
      cache32Bit = true;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Roboto" ];
        serif = [ "Roboto Slab" ];
      };
    };

    fonts = with pkgs; [
      terminus_font
      source-sans-pro
      roboto
      cozette
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix
      (nerdfonts.override {
        fonts = [ "Iosevka" "FiraCode" "FiraMono" "JetBrainsMono" ];
      })
      siji # https://github.com/stark/siji
      ipafont
      noto-fonts-emoji
      source-code-pro
    ];
  };
  i18n.defaultLocale = "en_US.UTF-8";
  environment.pathsToLink = [ "/libexec" "/share/zsh" ];
  environment.systemPackages = with pkgs; [ font-manager ];

}
