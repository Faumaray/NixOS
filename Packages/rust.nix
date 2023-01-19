
{ inputs, lib, config, pkgs, host, ... }: 
let
rust =  pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
        extensions = [ 
            "rust-src" 
            "rust-std"
            "llvm-tools-preview"
            "clippy-preview"
            "rust-analyzer-preview"
            "rustfmt-preview"
        ];
        targets = [ 
            "x86_64-unknown-linux-gnu" 
            "x86_64-pc-windows-gnu"
            "wasm32-unknown-unknown"
            "x86_64-linux-android"
        ];
    });
in
{

  home.packages = with pkgs; [
       mold
       rust
  ];
}
