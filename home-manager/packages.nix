{ pkgs, extras, ... }:
with pkgs; [
  # programs
  swappy
  sway-launcher-desktop
  ansible
  git
  rnix-lsp
  wayland
  xwayland
  glib
  wireplumber
  numix-icon-theme-circle
  grim
  slurp
  wl-clipboard
  wget
  bat
  firefox-wayland
  gcc
  nodejs-16_x
  postman
  python3Full
  ripgrep

  # language servers
  gopls
  nodePackages."bash-language-server"
  nodePackages."typescript"
  nodePackages."typescript-language-server"
  nodePackages."vscode-langservers-extracted"
  nodePackages."yaml-language-server"
  python3Packages."python-lsp-server"
  sumneko-lua-language-server
] ++ extras
