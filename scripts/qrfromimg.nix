{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellScriptBin "qrfromimg" ''
  img="$1"
  if [ ! -f "$img" ]; then
    echo "file $img does not exist"
    exit 1
  fi

  ${pkgs.zbar}/bin/zbarimg "$img"
''
