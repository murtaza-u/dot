{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellScriptBin "fish" ''
  exec ${pkgs.asciiquarium}/bin/asciiquarium
''
