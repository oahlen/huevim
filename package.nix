{
  lib,
  rustPlatform,
}:
let
  fs = lib.fileset;
  sourceFiles = fs.unions [
    ./Cargo.toml
    ./Cargo.lock
    (fs.fileFilter (file: file.hasExt "rs") ./src)
  ];

in
rustPlatform.buildRustPackage {
  pname = "huevim";
  version = "0.5.0";

  src = fs.toSource {
    root = ./.;
    fileset = sourceFiles;
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = {
    description = "Neovim lua color scheme generator written in Rust.";
    mainProgram = "huevim";
    homepage = "https://github.com/oahlen/huevim";
    license = with lib.licenses; [ mit ];
  };
}
