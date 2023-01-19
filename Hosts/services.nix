{ inputs, host, overlays, lib, config, pkgs, ... }: {
  security.sudo = {
    enable = true;
    # Allow passwordless sudo 
  };

  services.openssh = {
    enable = lib.mkForce true;
    permitRootLogin = "no";
    passwordAuthentication = lib.mkForce true;
  };

  services = {
    tlp.enable = true; # TLP and auto-cpufreq for power management
    #logind.lidSwitch = "ignore";           # Laptop does not go to sleep when lid is closed
    auto-cpufreq.enable = true;
    blueman.enable = true;
  };

  services.udev = {
    enable = true;
    extraRules = ''
      SUBSYSTEM=="rfkill", ATTR{type}=="bluetooth", ATTR{state}="1"
    '';
  };

  programs.xwayland.enable = true;
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true;
    displayManager.sddm = {
      enable = true;
    };
    displayManager.defaultSession = "hyprland";
    videoDrivers = [ "nvidia" ];
  };

  sound.enable = true;

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.dbus.enable = true;

  services.xl2tpd.enable = true;

  services.udisks2.enable = true;

  # Enable libvirtd
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf.enable = true;
      verbatimConfig = ''
         nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
         nographics_allow_host_audio = 1
        '';
    };
  };

  services = {
    btrfs.autoScrub.enable = true;
    fstrim.enable = true;
  };

  services.strongswan = {
    enable = true;
    secrets = [ "ipsec.d/ipsec.nm-l2tp.secrets" ];
  };

}
