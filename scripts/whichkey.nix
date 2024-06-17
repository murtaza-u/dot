{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellScriptBin "whichkey" ''
  ${pkgs.xorg.xev}/bin/xev |\
    awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
''
