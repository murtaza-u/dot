{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellScriptBin "k" ''
  exec ${pkgs.kubectl}/bin/kubectl "$@"
''
