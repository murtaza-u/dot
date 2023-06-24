{ pkgs }:

pkgs.writeShellScriptBin "fish" ''
  exec ${pkgs.asciiquarium}/bin/asciiquarium
''
