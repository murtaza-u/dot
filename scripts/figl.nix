{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellScriptBin "figl" ''
  clear=$'\033[2J'
  top=$'\033[H'

  trap 'setterm --cursor on; stty echo; echo ''${clear}; exit; trap -- - SIGINT SIGTERM' SIGTERM SIGINT

  echo "''${clear}"
  while true; do
    echo "''${top}"
    stty -echo
    setterm --cursor off
    ${pkgs.figlet}/bin/figlet -f "$HOME/.dot/store/future.tlf" -c -t "$*" |\
      ${pkgs.lolcat}/bin/lolcat 2>/dev/null
    setterm --cursor off
    sleep 3
  done
''
