
{ inputs, lib, config, pkgs, host, ... }: 
let
  prime-run = pkgs.writeShellScriptBin "prime-run" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';  
  in
{
  home.packages = with pkgs; [
    qemu
    virt-manager
    bottles
    rofi
    qt5ct
    libsForQt5.qtstyleplugin-kvantum
    ntfs3g
    pcmanfm-qt
    cachix
    wine-lol-wayland
    gamescope
    winetricks
    direnv
    samba
    neovim
    brave
    prime-run
    cmake
    gnumake
    nil
    xdg-utils
    obsidian
    firefox-wayland
    ripgrep
    libreoffice-fresh
    tdesktop
    sirula
    wofi
    grim
    swappy
    slurp
    pavucontrol
    alsa-utils
    gcc
    wl-clipboard
    hyprpaper
    glxinfo
    steam-run
    webcord
    pob-community
    nixgl.auto.nixGLDefault
    nixgl.auto.nixVulkanNvidia
    nixgl.nixVulkanIntel
  ];
}
