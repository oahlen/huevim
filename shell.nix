{
  pkgs ? import <nixpkgs> {
    config = { };
    overlays = [ ];
  },
}:
pkgs.mkShell {
  NIX_SHELL = "HueVim";

  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

  packages = with pkgs; [
    cargo
    clippy
    pkg-config
    rust-analyzer
    rustc
    rustfmt
  ];
}
