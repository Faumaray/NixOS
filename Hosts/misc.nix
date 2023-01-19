{ inputs, host, overlays, lib, config, pkgs, ... }: {
  users.users.faumaray = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [ "wheel" "libvirtd" "networkmanager" "audio" "video" "storage" ];
  };
  users.groups.libvirtd.members = ["root" "faumaray" ];

  programs.hyprland = {
    enable = true;
    recommendedEnvironment = true;
  };
  programs.zsh.enable = true;
  # TODO: Set your hostname
  networking.hostName = host.hostName;
  networking.networkmanager = {
    enable = true;
    enableStrongSwan = true;
  };
  programs.steam.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  programs = { # No xbacklight, this is the alterantive
    dconf.enable = true;
    light.enable = true;
  };

  time.hardwareClockInLocalTime = true;
  time.timeZone = "Europe/Samara";
}
