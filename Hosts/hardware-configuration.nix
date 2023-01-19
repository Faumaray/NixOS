{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  # boot.initrd.kernelModules = ["kvmgt" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
  # boot.kernelModules = [ "kvm-intel" "kvmgt" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio-mdev" "vfio" "vhost-net" ];
  # boot.kernelParams = [ "i915.enable_gvt=1""i915.enable_guc=0" "kvmgt" "intel_iommu=on" "iommu=pt" "intel_iommu=igfx_off" "kvm.ignore_rsms=1" "kmv.report_ignored_msrs=0" "vfio-pci.ids=10de:1d10"];
  # boot.extraModprobeConfig ="options i915.enable_gvt=1 i915.enable_guc=0 kvm_intel nested=1";
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel"  ];
  boot.kernelParams = [ ];
  boot.extraModprobeConfig ="options ikvm_intel";
  #
  #   boot.postBootCommands = ''
  #   # Setup Looking Glass shared memory object
  #   touch /dev/shm/looking-glass
  #   chown faumaray:users /dev/shm/looking-glass
  #   chmod 660 /dev/shm/looking-glass
  #   echo 'd6fa8eca-68d7-41fb-863b-bd0af025c987' > /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/create
  # '';
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4139a7e8-4037-4a46-83b9-94b504712742";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CEF7-E343";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/a7397657-46c5-4491-861b-635e3426382c";
    fsType = "btrfs";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/cdd5f0fa-2be3-4493-b95a-7e446b65e29a"; }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      prime = {
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
        offload.enable = true;
      };
      powerManagement.enable = true;
      nvidiaPersistenced = true;
      modesetting.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
      powerOnBoot = true;
    };
    enableRedistributableFirmware = true;
  };

}
