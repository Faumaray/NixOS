let
  system =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKgzoMXQTXzNRa1YllNDjlyIBXQ+OPQxS9bH2LZjcp+p root@nixos";
  user =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5heDrzdM7JsZ8DQ97AdqFlUbMIFQCxgeSWifoFm7FR faumaray@gmail.com";
  allKeys = [ system user ];
in { "ssh.age".publicKeys = allKeys; }
