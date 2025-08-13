{
  description = "Neovim lua color scheme generator written in Rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";
    crane.url = "github:ipetkov/crane";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    crane,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        craneLib = crane.mkLib pkgs;

        commonArgs = {
          src = craneLib.cleanCargoSource ./.;
          buildInputs = with pkgs; [pkg-config];
        };

        bin = craneLib.buildPackage (
          commonArgs
          // {
            cargoArtifacts = craneLib.buildDepsOnly commonArgs;
          }
        );
      in
        with pkgs; {
          packages.default = bin;

          devShells.default = craneLib.devShell {
            buildInputs = [
              clippy
              rust-analyzer
              rustfmt
            ];
          };
        }
    );
}
